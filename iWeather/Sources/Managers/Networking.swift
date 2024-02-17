//
//  Networking.swift
//  iWeather
//
//  Created by 1234 on 14.02.2024.
//

import Foundation
import Alamofire
import SVGKit

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    let global = DispatchQueue.global(qos: .utility)
    
    private func createURL(baseURL: String, path: String?, queryItems: [URLQueryItem]? = nil) -> URL? {
        // Проверяем, есть ли путь (path)
        if let path = path, !path.isEmpty {
            // Если путь существует и не пуст, создаем URL с полным путем
            var components = URLComponents(string: baseURL)
            components?.path = path
            components?.queryItems = queryItems
            return components?.url
        } else {
            // Если путь отсутствует или пуст, используем базовый URL
            return URL(string: baseURL)
        }
    }
    
    func fetchAPIData(lat: String?, lon: String?,
                      completion: @escaping ((Weather) -> Void)) {
        let baseURL = "https://api.weather.yandex.ru"
        let urlPath = "/v2/forecast"
        let queryItem = [URLQueryItem(name: "lat", value: lat),
                         URLQueryItem(name: "lon", value: lon),
                         URLQueryItem(name: "lang", value: "ru_RU"),
                         URLQueryItem(name: "limit", value: "1"),
                         URLQueryItem(name: "hours", value: "true"),
                         URLQueryItem(name: "extra", value: "true")]
        
        let apiKey = "19e5e102-6dc3-4c20-8d3f-c815f3af8184"
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": apiKey
        ]
        
        let urlRequest = createURL(baseURL: baseURL, path: urlPath, queryItems: queryItem)
        
        guard let url = urlRequest else {
            return
        }
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headers,
            interceptor: nil
        ).response { resp in
            switch resp.result {
            case .success(let data):
                do {
                    if let data = data {
                        let weatherData = try JSONDecoder().decode(WeatherCity.self, from: data)
                        guard let weather = Weather(weatherData: weatherData) else { return }
                        completion(weather)
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func loadSVGImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        global.async {
           
            guard let svgData = try? Data(contentsOf: url),
                  let svgImage = SVGKImage(data: svgData),
                  let uiImage = svgImage.uiImage
            else {
                completion(UIImage(named: "cloud.fill"))
                return
            }
                completion(uiImage)
        }
    }
}
