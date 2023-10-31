//
//  DailyForecastData.swift
//  Weather
//
//  Created by Вячеслав on 10/29/23.
//

import Foundation

// MARK: - FiveWeatherForecastData
struct FiveDayWeatherForecastData: Codable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let name: String
}


// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String
    var systemIconNameString: String {
        switch weather.first!.id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop
        case dtTxt = "dt_txt"
    }
}

    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int
    }

    // MARK: - MainClass
    struct MainClass: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int
        

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            
        }
    }


// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    var descriptionString: String {
        if description == "небольшая облачность" ||
           description == "переменная облачность" {
            return "облачность"
        } else {
            return description
        }
    }
}


// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
