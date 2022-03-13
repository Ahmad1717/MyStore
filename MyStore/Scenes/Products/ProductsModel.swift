//
//  ProductsModel.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

class Product: Decodable {
    var id: StringOrInt?
    var brand: Brand?
    var phone: String?
    var picture: String?
    var announceDate: StringOrInt?
    var sim: String?
    var resolution: String?
    var audio: String?
    var gps: String?
    var battery: String?
    var price: StringOrInt?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case brand
        case phone
        case picture
        case announceDate
        case sim
        case resolution
        case audio = "audioJack"
        case gps
        case battery
        case price = "priceEur"
    }
    
    init(id: StringOrInt? = nil,
         brand: Brand? = nil,
         phone: String? = nil,
         picture: String? = nil,
         announceDate: StringOrInt? = nil,
         sim: String? = nil,
         resolution: String? = nil,
         audio: String? = nil,
         gps: String? = nil,
         battery: String? = nil,
         price: StringOrInt? = nil) {
        self.brand = brand
        self.id = id
        self.picture = picture
        self.phone = phone
        self.announceDate = announceDate
        self.sim = sim
        self.resolution = resolution
        self.audio = audio
        self.gps = gps
        self.battery = battery
        self.price = price
    }
    
    enum StringOrInt: Decodable {
        
        case string(String)
        case int(Int)
        
        var stringValue: String? {
            switch self {
            case .string(let string): return string
            case .int(let int): return String(int)
            }
        }
        
        var intValue: Int? {
            switch self {
            case .string(let string): return Int(string)
            case .int(let int): return int
            }
        }
        
        init(from decoder: Decoder) throws {
            if let int = try? decoder.singleValueContainer().decode(Int.self) {
                self = .int(int)
                return
            }
            
            if let string = try? decoder.singleValueContainer().decode(String.self) {
                self = .string(string)
                return
            }
            
            throw Error.couldNotFindStringOrInt
        }
        
        enum Error: Swift.Error {
            case couldNotFindStringOrInt
        }
    }
}

enum Brand: String, Decodable, CaseIterable {
    case apple = "Apple"
    case ericsson = "Ericsson"
    case none = ""
}

enum ProductServiceModule: ServiceModule {
    
    case fetchProducts
    
    var method: RequestMethod {
        switch self {
        case .fetchProducts: return .get
        }
    }
    
    var module: Module? {
        switch self {
        case .fetchProducts: return .products
        }
    }

    var path: Path? {
        switch self {
        case .fetchProducts: return .id
        }
    }

    var parameters: Parameters? { nil }
}
