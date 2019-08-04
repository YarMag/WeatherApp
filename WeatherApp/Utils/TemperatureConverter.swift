//
//  TemperatureConverter.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

/// Helper class for temperature conversion
class TemperatureConverter
{
    static func kelvinToCelsius(_ value: Double) -> Double
    {
        // round to have 1 digit at fractional part
        return round((value - 273.15) * 10) / 10
    }
}
