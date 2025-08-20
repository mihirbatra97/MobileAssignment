//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    @State private var searchText = ""
    
    var filteredDevices: [DeviceData] {
        guard let devices = viewModel.data else { return [] }
        if searchText.isEmpty {
            return devices
        } else {
            // Perform prefix search on device names
            return devices.filter { device in
                device.name.lowercased().hasPrefix(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search devices", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Group {
                    if !filteredDevices.isEmpty {
                        DevicesList(devices: filteredDevices) { selectedComputer in
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                        }
                    } else if viewModel.data == nil {
                        ProgressView("Loading...")
                    } else {
                        Text("No matching devices found")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail, { oldValue, newValue in
                if let navigate = newValue {
                    path.append(navigate)
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                // Fetch data when view appears
                viewModel.fetchAPI()
            }
        }
    }
}
