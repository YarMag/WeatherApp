//
//  DayTableViewCell.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 04/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit

/// Cell presents part of day forecast.
class DayTableViewCell: UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        _init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    /// Presents part of day forecast
    func show(dayPartForecast: DayPartForecast)
    {
        self.imageView?.image = UIImage(named: dayPartForecast.weatherSummary.iconId)
        self.textLabel?.text = _dateFormatter.string(from: dayPartForecast.dateTime)
       
        let windDescription = NSLocalizedString("wind", comment: "") + ": " + dayPartForecast.wind.speed.description + NSLocalizedString("windSpeed", comment: "")
        
        let tempDescription = NSLocalizedString("temp", comment: "") + ": " + dayPartForecast.weatherDetails.temp.description
        
        let weatherDescription = NSLocalizedString(dayPartForecast.weatherSummary.description, comment: "")
        
        self.detailTextLabel?.text = weatherDescription + ", " + tempDescription + ", " + windDescription
        self.detailTextLabel?.sizeToFit()
    }
    
    // MARK: - Private methods
    
    /// Configures view.
    private func _init()
    {
        self.detailTextLabel?.lineBreakMode = .byWordWrapping
        self.detailTextLabel?.numberOfLines = 2
        
        _dateFormatter.timeStyle = .short
        _dateFormatter.locale = .current
    }
    
    private let _dateFormatter = DateFormatter()
}
