//
//  WeatherServiceDelegate.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

protocol WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate? { get set }
    
    /// Requests weather forecast for 5 days for specified location.
    func requestWeatherForecast(forLatitude latitude: Double, withLongitude longtitude: Double)
    
    /// Requests current weather for specified location.
    func requestCurrentWeather(forLatitude latitude: Double, withLongitude longitude: Double)
}
