//
//  DayViewLabel.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 04/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit

class DayViewLabel: UILabel
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
