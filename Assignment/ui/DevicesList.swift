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
                            if let color = data.color ?? data.dataColor {
                                Text("Color: \(color)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Display capacity information
                            if let capacity = data.capacity ?? data.dataCapacity {
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
                            if let generation = data.generation ?? data.dataGeneration {
                                Text("Generation: \(generation)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            if let caseSize = data.caseSize {
                                Text("Case Size: \(caseSize)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
