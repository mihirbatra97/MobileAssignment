//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection

    var body: some View {
        List(devices) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading, spacing: 6) {
                    AssignmentText(text: device.name)
                    
                    // Display additional device details if available
                    if let data = device.data {
                        Group {
                            // Display color information
                            if let color = data.dataColor ?? data.color {
                                Text("Color: \(color)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display capacity information
                            if let capacity = data.dataCapacity ?? data.capacity {
                                Text("Capacity: \(capacity)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else if let capacityGB = data.capacityGB {
                                Text("Capacity: \(capacityGB) GB")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display price information if available
                            if let price = data.dataPrice {
                                Text("Price: $\(String(format: "%.2f", price))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else if let priceStr = data.price {
                                Text("Price: $\(priceStr)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display additional specs if available
                            if let generation = data.dataGeneration ?? data.generation {
                                Text("Generation: \(generation)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            if let caseSize = data.caseSize {
                                Text("Case Size: \(caseSize)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display CPU model if available
                            if let cpuModel = data.cpuModel {
                                Text("CPU: \(cpuModel)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display hard disk size if available
                            if let hardDiskSize = data.hardDiskSize {
                                Text("Storage: \(hardDiskSize)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display screen size if available
                            if let screenSize = data.screenSize {
                                Text("Screen: \(String(format: "%.1f", screenSize))\"")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display year if available
                            if let year = data.year {
                                Text("Year: \(year)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display description if available
                            if let description = data.description {
                                Text("\(description)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
