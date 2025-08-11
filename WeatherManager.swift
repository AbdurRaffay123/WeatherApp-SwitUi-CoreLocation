//
//  Managers/WeatherManager.swift
//  WeatherDemo
//
//  Created by hst on 11/08/2025.
//

import Foundation
import CoreLocation

class WeatherManager {
    // Using completion handler for iOS14 compatibility
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<ResponseBody, Error>) -> Void) {
        // Replace with your own API key or use a secure method for storing
        let apiKey = "0963facb079e0fed4e840b24e9931d72"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            completion(.failure(NSError(domain: "WeatherManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing URL"])))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "WeatherManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error fetching weather data"])))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "WeatherManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(ResponseBody.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


import Foundation

struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
}

struct CoordinateResponse: Decodable {
    var lon: Double
    var lat: Double
}

struct WeatherResponse: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainResponse: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
}
