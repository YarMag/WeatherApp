//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 03/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit

/// Cell presents day in weather forecast
class WeatherTableViewCell: UITableViewCell
{   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        _init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func show(dayPartForecast: DayPartForecast)
    {
        self.imageView?.image = UIImage(named: dayPartForecast.weatherSummary.iconId)
        self.textLabel?.text = _dateFormatter.string(from: dayPartForecast.dateTime)
    }
    
    // MARK: - Private methods
    
    /// Configures view.
    private func _init()
    {
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.minimumScaleFactor = 0.2
        
        _dateFormatter.timeStyle = .none
        _dateFormatter.dateStyle = .full
        _dateFormatter.locale = .current
    }
    
    // MARK: - Private properties
    
    private let _dateFormatter = DateFormatter()
}
