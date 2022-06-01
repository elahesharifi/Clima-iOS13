//
//  WeatherData.swift
//  Clima
//
//  Created by Elahe  Sharifi on 31/05/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main : Main
    let weather : [Weather]
}

struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
}
