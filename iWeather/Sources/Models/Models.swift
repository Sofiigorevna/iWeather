//
//  Models.swift
//  iWeather
//
//  Created by 1234 on 12.02.2024.
//

import Foundation

struct WeatherCity: Decodable {
    let geoObject: GeoObject
    let fact: Fact
    var forecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case forecasts
        case geoObject = "geo_object"
        case fact
    }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let locality: City
}

struct City: Decodable {
    let name: String
}

// MARK: - Fact
struct Fact: Decodable {
    let temp: Double
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case temp, condition
    }
}

// MARK: - Forecast
struct Forecast: Decodable {
    let date: String
    let hours: [Hour]
    let parts: Parts
    
    enum CodingKeys: String, CodingKey {
        case date
        case parts
        case hours
    }
}

// MARK: - Hour
struct Hour: Decodable {
    let hour: String
    let temp: Int
    let icon: String
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case hour, temp, icon, condition
    }
}

struct Parts: Decodable {
    let day: Day
    
    enum CodingKeys: String, CodingKey {
        case day
    }
}

// MARK: - Day
struct Day: Decodable {
    let tempMin, tempMax: Int?
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case icon
    }
}

struct CellBackground {
    let image: String
}

extension CellBackground {
    static var allImages = [
        CellBackground(image: "8"),
        CellBackground(image: "3"),
        CellBackground(image: "1"),
        CellBackground(image: "6"),
        CellBackground(image: "5"),
        CellBackground(image: "4"),
        CellBackground(image: "7"),
        CellBackground(image: "9"),
        CellBackground(image: "2"),
        CellBackground(image: "10"),
    ]
}
