//
//  WeatherSummary.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation

class WeatherSummary
{
    public private(set) var description: String
    public private(set) var iconId: String
    public private(set) var main: String
    
    init?(withJSON json: [String: Any])
    {
        guard let descriptionValue = json["description"] as? String else { return nil }
        description = descriptionValue
        
        guard let iconIdValue = json["icon"] as? String else { return nil }
        iconId = iconIdValue
        
        guard let mainValue = json["main"] as? String else { return nil }
        main = mainValue
    }
}
