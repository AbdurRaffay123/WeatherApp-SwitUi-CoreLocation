//
//  Views/ContentView.swift
//  WeatherDemo
//
//  Created by hst on 11/08/2025.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let w = weather {
                    WeatherView(weather: w)
                } else {
                    LoadingView()
                        .onAppear {
                            // Fetch weather using completion based manager
                            weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude) { result in
                                switch result {
                                case .success(let responseBody):
                                    DispatchQueue.main.async {
                                        self.weather = responseBody
                                    }
                                case .failure(let error):
                                    print("Error getting weather: \(error)")
                                }
                            }
                        }
                }
                
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
    }
}
