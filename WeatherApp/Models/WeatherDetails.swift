//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class WeatherDetails
{
    public private(set) var humidity: Double
    public private(set) var pressure: Double
    public private(set) var temp: Measurement<UnitTemperature>
    public private(set) var tempMax: Measurement<UnitTemperature>
    public private(set) var tempMin: Measurement<UnitTemperature>
    public private(set) var grndLevel: Double?
    public private(set) var seaLevel: Double?
    
    init?(withJSON json: [String: Any])
    {
        // required properties
        guard let humidityValue = json["humidity"] as? Double else { return nil }
        humidity = humidityValue
        
        guard let pressureValue = json["pressure"] as? Double else { return nil }
        pressure = pressureValue
        
        guard let tempValue = json["temp"] as? Double else { return nil }
        temp = Measurement(value: TemperatureConverter.kelvinToCelsius(tempValue), unit: UnitTemperature.celsius)
        
        guard let tempMaxValue = json["temp_max"] as? Double else { return nil }
        tempMax = Measurement(value: TemperatureConverter.kelvinToCelsius(tempMaxValue), unit: UnitTemperature.celsius)
        
        guard let tempMinValue = json["temp_min"] as? Double else { return nil }
        tempMin = Measurement(value: TemperatureConverter.kelvinToCelsius(tempMinValue), unit: UnitTemperature.celsius)
        
        // optional properties
        if let grndLevelValue = json["grnd_level"] as? Double { grndLevel = grndLevelValue }
        
        if let seaLevelValue = json["sea_level"] as? Double { seaLevel = seaLevelValue }
    }
}
