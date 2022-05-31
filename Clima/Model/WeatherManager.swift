//
//  WeatherManager.swift
//  Clima
//
//  Created by Elahe  Sharifi on 31/05/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a64d08bd6967da0ccccb95ec1c5e50b1&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1.Create a URL
        if let url = URL(string: urlString){
            //2.Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString)
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
}
