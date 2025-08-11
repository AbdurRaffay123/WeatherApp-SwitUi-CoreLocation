//
//  Views/WeatherView.swift
//  WeatherDemo
//
//  Created by hst on 11/08/2025.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    // Date formatters for iOS14
    private var weekdayFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "EEEE" // weekday full name
        return f
    }
    private var dateTimeFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name).bold().font(.title)
                    Text("\(weekdayFormatter.string(from: Date())), \(dateTimeFormatter.string(from: Date()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            Text(weather.weather.first?.main ?? "")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text("\(weather.main.feels_like.roundDouble())°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer().frame(height: 80)
                    
                    Image("city-images")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now").bold().padding(.bottom, 5)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min Temp", value: "\(weather.main.temp_min.roundDouble())°")
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: "\(weather.main.temp_max.roundDouble())°")
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind Speed", value: "\(weather.wind.speed.roundDouble()) m/s")
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(Color.white)
                .cornerRadius(20)
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
