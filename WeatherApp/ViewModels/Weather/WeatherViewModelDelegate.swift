//
//  WeatherViewModelDelegate.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

/// WeatherViewModelDelegate interface
protocol WeatherViewModelDelegate: class
{
    /// Notifies that weather forecast was loaded.
    func didLoadForecast(forecast: WeatherForecast)
    
    /// Notifies that current weather was loaded.
    func didLoadCurrentWeather(weather: CurrentWeather)
    
    /// Presents forecast for exact day.
    func presentDayForecast(dayForecast: [DayPartForecast])
}
