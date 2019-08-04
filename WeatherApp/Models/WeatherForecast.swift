//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class WeatherForecast
{
    public private(set) var city: City
    public private(set) var days: [DayPartForecast] = []
    
    init?(withJSON json: [String: Any])
    {
        guard let cityJSON = json["city"] as? [String: Any] else { return nil }
        guard let cityValue = City(withJSON: cityJSON) else { return nil }
        city = cityValue
        
        guard let daysJSON = json["list"] as? [[String: Any]] else { return nil }
        for dayJSON in daysJSON
        {
            guard let dayValue = DayPartForecast(withJSON: dayJSON) else { return nil}
            days.append(dayValue)
        }
    }
}
