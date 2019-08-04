//
//  City.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation
import CoreLocation

class City
{
    public private(set) var coord: CLLocation
    public private(set) var country: String
    public private(set) var name: String
    
    init?(withJSON json: [String: Any])
    {
        guard let nameValue = json["name"] as? String else { return nil }
        name = nameValue
        
        guard let countryValue = json["country"] as? String else { return nil }
        country = countryValue
        
        guard let coordValue = json["coord"] as? [String: Any] else {return nil}
        guard let coordLatValue = coordValue["lat"] as? Double else { return nil }
        guard let coordLonValue = coordValue["lon"] as? Double else { return nil }
        coord = CLLocation(latitude: coordLatValue, longitude: coordLonValue)
    }
}
