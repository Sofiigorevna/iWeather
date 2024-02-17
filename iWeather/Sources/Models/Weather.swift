//
//  Weather.swift
//  iWeather
//
//  Created by 1234 on 15.02.2024.
//

import Foundation

struct Weather {
    
    // for geo
    var locality: String = ""

    // for fact
    var iconCondition: String = ""
    var condition: String = ""
    var temperature: Double = 0.0

    var temperatureString: String {
        return String(format: "%.0f", temperature) + "º"
    }
    
    // for forecast
    var date: String = ""
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "d MMM"
            
            return newDateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    // for hour
    var hours = [Hour]()
    
    // for day
    var tempMin: Int = 0

    var tempMinString: String {
        return String(tempMin) + "º C"
    }
    
    var tempMax: Int = 0

    var tempMaxString: String {
        return String(tempMax) + "º C"
    }

    var conditionTranslate: String {
        switch condition {
        case "clear":                  return "Ясно"
        case "partly-cloudy":          return "Малооблачно"
        case "cloudy":                 return "Облачно с прояснениями"
        case "overcast":               return "Пасмурно"
        case "drizzle":                return "Морось"
        case "light-rain":             return "Небольшой дождь"
        case "rain":                   return "Дождь"
        case "moderate-rain":          return "Умеренно сильный дождь"
        case "heavy-rain":             return "Сильный дождь"
        case "continuous-heavy-rain":  return "Длительный сильный дождь"
        case "showers":                return "Ливень"
        case "wet-snow":               return "Дождь со снегом"
        case "light-snow":             return "Небольшой снег"
        case "snow":                   return "Снег"
        case "snow-showers":           return "Снегопад"
        case "hail":                   return "Град"
        case "thunderstorm":           return "Гроза"
        case "thunderstorm-with-rain": return "Дождь с грозой"
        case "thunderstorm-with-hail": return "Гроза с градом"

        default: return "Загрузка..."

        }
    }

    init?(weatherData: WeatherCity) {
       locality = weatherData.geoObject.locality.name
        temperature = weatherData.fact.temp
        condition = weatherData.fact.condition
        date = weatherData.forecasts.first?.date ?? ""
        tempMin = weatherData.forecasts.first?.parts.day.tempMin ?? 0
        tempMax = weatherData.forecasts.first?.parts.day.tempMax ?? 0
        iconCondition = weatherData.forecasts.first?.parts.day.icon ?? ""
        
        if let hours = weatherData.forecasts.first?.hours {
            self.hours = hours
        }

    }    
}

