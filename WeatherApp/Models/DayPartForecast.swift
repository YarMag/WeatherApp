//
//  DayPartForecast.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class DayPartForecast
{
    public private(set) var clouds: Clouds
    public private(set) var weatherDetails: WeatherDetails
    public private(set) var wind: Wind
    public private(set) var weatherSummary: WeatherSummary
    public private(set) var dateTime: Date
    
    init?(withJSON json: [String: Any])
    {
        guard let cloudsJSON = json["clouds"] as? [String: Any] else { return nil }
        guard let cloudsValue = Clouds(withJSON: cloudsJSON) else { return nil }
        clouds = cloudsValue
        
        guard let dateTimeValue = json["dt"] as? Double else { return nil }
        dateTime = Date(timeIntervalSince1970: dateTimeValue)
        
        guard let weatherDetailsJSON = json["main"] as? [String: Any] else { return nil }
        guard let weatherDetailsValue = WeatherDetails(withJSON: weatherDetailsJSON) else { return nil }
        weatherDetails = weatherDetailsValue
        
        guard let windJSON = json["wind"] as? [String: Any] else { return nil }
        guard let windValue = Wind(withJSON: windJSON) else { return nil }
        wind = windValue
        
        guard let weatherSummaryJSON = json["weather"] as? [[String: Any]] else { return nil }
        guard let weatherSummaryValue = WeatherSummary(withJSON: weatherSummaryJSON[0]) else { return nil }
        weatherSummary = weatherSummaryValue
    }
}
