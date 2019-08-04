//
//  WeatherViewModelProtocol.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

/// WeatherViewModel interface
protocol WeatherViewModelProtocol: WeatherServiceDelegate
{
    var delegate: WeatherViewModelDelegate? { get set }
    
    /// Requests weather forecast.
    func requestWeatherForecast()
    
    /// Requests weather at current moment.
    func requestCurrentWeather()
    
    /// Tells that some day in weather forecast was selected.
    func onDaySelected(dayIndex: Int)
}
