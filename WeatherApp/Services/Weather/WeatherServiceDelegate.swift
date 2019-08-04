//
//  WeatherServiceDelegate.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate: class
{
    /// Notifies that weather forecast was loaded.
    func didLoadForecast(_ data: WeatherForecast)
    
    /// Notifies that current weather was loaded.
    func didLoadCurrentWeather(_ weather: CurrentWeather)
}
