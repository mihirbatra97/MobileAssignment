//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []

    init() {
        // Call fetchAPI automatically when ViewModel is initialized
        fetchAPI()
    }

    func fetchAPI() {
        print("ContentViewModel: Starting API fetch")
        apiService.fetchDeviceDetails(completion: { items in
            print("ContentViewModel: Received \(items.count) items from API")
            if !items.isEmpty {
                print("ContentViewModel: First item name: \(items[0].name)")
            }
            self.data = items
        })
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
