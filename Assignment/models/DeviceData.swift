//
//  ComputerItem.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


// MARK: - DeviceData
struct DeviceData: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: DeviceData, rhs: DeviceData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: String
    let data: ItemData?
    
    // Custom decoding to handle the API format
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        data = try container.decodeIfPresent(ItemData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, data
    }
}

// MARK: - ItemData
struct ItemData: Codable, Hashable {
    // Store all values in a dictionary to handle dynamic keys
    private var values: [String: AnyCodable] = [:]
    
    // Computed properties to access common fields
    var color: String? {
        return values["color"]?.value as? String ?? values["Color"]?.value as? String
    }
    
    var capacity: String? {
        return values["capacity"]?.value as? String ?? values["Capacity"]?.value as? String
    }
    
    var capacityGB: Int? {
        return values["capacity GB"]?.value as? Int
    }
    
    var price: String? {
        if let priceDouble = values["price"]?.value as? Double {
            return String(format: "%.2f", priceDouble)
        }
        return values["Price"]?.value as? String
    }
    
    var priceDouble: Double? {
        if let price = values["price"]?.value as? Double {
            return price
        }
        if let priceStr = values["Price"]?.value as? String, let price = Double(priceStr) {
            return price
        }
        return nil
    }
    
    var generation: String? {
        return values["generation"]?.value as? String ?? values["Generation"]?.value as? String
    }
    
    var year: Int? {
        return values["year"]?.value as? Int
    }
    
    var cpuModel: String? {
        return values["CPU model"]?.value as? String
    }
    
    var hardDiskSize: String? {
        return values["Hard disk size"]?.value as? String
    }
    
    var strapColour: String? {
        return values["Strap Colour"]?.value as? String
    }
    
    var caseSize: String? {
        return values["Case Size"]?.value as? String
    }
    
    var description: String? {
        return values["Description"]?.value as? String
    }
    
    var screenSize: Double? {
        return values["Screen size"]?.value as? Double
    }
    
    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: DynamicCodingKeys.self) {
            for key in container.allKeys {
                let value = try container.decode(AnyCodable.self, forKey: key)
                values[key.stringValue] = value
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (key, value) in values {
            try container.encode(value, forKey: DynamicCodingKeys(stringValue: key))
        }
    }
    
    // For Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(values)
    }
    
    static func == (lhs: ItemData, rhs: ItemData) -> Bool {
        return lhs.values == rhs.values
    }
    
    // Dynamic coding keys to handle any key in the JSON
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
}

// Helper struct to handle any type of value in JSON
struct AnyCodable: Codable, Hashable {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if container.decodeNil() {
            value = NSNull()
        } else if let arrayValue = try? container.decode([AnyCodable].self) {
            value = arrayValue.map { $0.value }
        } else if let dictionaryValue = try? container.decode([String: AnyCodable].self) {
            value = dictionaryValue.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyCodable")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let boolValue as Bool:
            try container.encode(boolValue)
        case let intValue as Int:
            try container.encode(intValue)
        case let doubleValue as Double:
            try container.encode(doubleValue)
        case let stringValue as String:
            try container.encode(stringValue)
        case is NSNull:
            try container.encodeNil()
        case let arrayValue as [Any]:
            try container.encode(arrayValue.map { AnyCodable($0) })
        case let dictionaryValue as [String: Any]:
            try container.encode(dictionaryValue.mapValues { AnyCodable($0) })
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Cannot encode value"))
        }
    }
    
    // For Hashable conformance
    func hash(into hasher: inout Hasher) {
        switch value {
        case let boolValue as Bool:
            hasher.combine(boolValue)
        case let intValue as Int:
            hasher.combine(intValue)
        case let doubleValue as Double:
            hasher.combine(doubleValue)
        case let stringValue as String:
            hasher.combine(stringValue)
        case is NSNull:
            hasher.combine(0)
        case let arrayValue as [AnyCodable]:
            hasher.combine(arrayValue)
        case let dictionaryValue as [String: AnyCodable]:
            hasher.combine(dictionaryValue)
        default:
            hasher.combine(String(describing: value))
        }
    }
    
    static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        switch (lhs.value, rhs.value) {
        case (let lhs as Bool, let rhs as Bool):
            return lhs == rhs
        case (let lhs as Int, let rhs as Int):
            return lhs == rhs
        case (let lhs as Double, let rhs as Double):
            return lhs == rhs
        case (let lhs as String, let rhs as String):
            return lhs == rhs
        case (is NSNull, is NSNull):
            return true
        case (let lhs as [String: AnyCodable], let rhs as [String: AnyCodable]):
            return lhs == rhs
        case (let lhs as [AnyCodable], let rhs as [AnyCodable]):
            return lhs == rhs
        default:
            return false
        }
    }
}
