//
//  Wind.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class Wind
{
    public private(set) var speed: Double
    public private(set) var deg: Double?
    
    init?(withJSON json: [String: Any])
    {
        // required properties
        guard let speedValue = json["speed"] as? Double else { return nil }
        speed = speedValue
        
        // optional properties
        if let degValue = json["deg"] as? Double { deg = degValue }
    }
}
