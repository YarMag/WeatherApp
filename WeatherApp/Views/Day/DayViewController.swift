//
//  DayViewController.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 04/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit

/// Manages view with concrete day forecast.
class DayViewController: UIViewController
{
    init(dayForecast: [DayPartForecast])
    {
        super.init(nibName: nil, bundle: nil)
        
        _dayForecast = dayForecast
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override UIViewController methods
    
    override func loadView()
    {
        let dayView = DayView(dayForecast: _dayForecast)
        
        self.view = dayView
    }
    
    // MARK: - Private properties
    
    private var _dayForecast: [DayPartForecast]!
}
