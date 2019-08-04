//
//  Clouds.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class Clouds
{
    public private(set) var all: Int
    
    init?(withJSON json: [String: Any])
    {
        guard let allValue = json["all"] as? Int else { return nil }
        all = allValue
    }
}
