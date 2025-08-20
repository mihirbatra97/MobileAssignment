//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService : NSObject {
    private let baseUrl = ""
    
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetails(completion : @escaping ([DeviceData]) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([]) // Return an empty array on network failure
                }
                return
            }
            
            if let data = data {
                do {
                    // Print raw JSON for debugging
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(jsonString)")
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    let empData = try jsonDecoder.decode([DeviceData].self, from: data)
                    
                    // Print decoded data for debugging
                    print("Successfully decoded \(empData.count) devices")
                    if !empData.isEmpty {
                        print("First device: id=\(empData[0].id), name=\(empData[0].name)")
                    }
                    
                    DispatchQueue.main.async {
                        completion(empData) // Return the decoded data
                    }
                } catch {
                    print("Decoding error: \(error)")
                    print("Decoding error description: \(error.localizedDescription)")
                    
                    // Try to decode a single item to see the structure
                    do {
                        let singleItem = try JSONDecoder().decode(DeviceData.self, from: data)
                        print("Single item decode worked: \(singleItem.name)")
                    } catch {
                        print("Single item decode also failed")
                    }
                    
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
