//
//  DetailView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DetailView: View {
    let device: DeviceData

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(device.name)
                .font(.largeTitle)
                .bold()
            
            if let data = device.data {
                VStack(alignment: .leading, spacing: 12) {
                    // Display color information
                    if let color = data.dataColor ?? data.color {
                        Text("Color: \(color)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display capacity information
                    if let capacity = data.dataCapacity ?? data.capacity {
                        Text("Capacity: \(capacity)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    } else if let capacityGB = data.capacityGB {
                        Text("Capacity: \(capacityGB) GB")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display price information
                    if let price = data.dataPrice {
                        Text("Price: $\(String(format: "%.2f", price))")
                            .font(.title2)
                            .foregroundColor(.green)
                            .bold()
                    } else if let priceStr = data.price {
                        Text("Price: $\(priceStr)")
                            .font(.title2)
                            .foregroundColor(.green)
                            .bold()
                    }
                    
                    // Display screen size
                    if let screenSize = data.screenSize {
                        Text("Screen Size: \(String(format: "%.1f", screenSize))\"")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display generation
                    if let generation = data.dataGeneration ?? data.generation {
                        Text("Generation: \(generation)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display CPU model
                    if let cpuModel = data.cpuModel {
                        Text("CPU: \(cpuModel)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display hard disk size
                    if let hardDiskSize = data.hardDiskSize {
                        Text("Storage: \(hardDiskSize)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display case size
                    if let caseSize = data.caseSize {
                        Text("Case Size: \(caseSize)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display strap colour
                    if let strapColour = data.strapColour {
                        Text("Strap Colour: \(strapColour)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display year
                    if let year = data.year {
                        Text("Year: \(year)")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    // Display description
                    if let description = data.description {
                        Text("Description:")
                            .font(.headline)
                            .padding(.top, 8)
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 16)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
