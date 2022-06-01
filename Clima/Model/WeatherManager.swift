//
//  WeatherManager.swift
//  Clima
//
//  Created by Elahe  Sharifi on 31/05/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather : WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
   
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a64d08bd6967da0ccccb95ec1c5e50b1&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1.Create a URL
        if let url = URL(string: urlString){
            //2.Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
     func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, ciyName: name, temperature: temp)
            return weather
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
     
}
