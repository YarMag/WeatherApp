//
//  WeatherView.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit
import SnapKit

/// View presents weather forecast.
class WeatherView: UIView
{
    init(viewController: WeatherViewController)
    {
        super.init(frame: CGRect.zero)
        
        _vc = viewController
        _init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func updateForecast(_ forecast: WeatherForecast)
    {
        _forecast = forecast
        
        _cityLabel.text = NSLocalizedString(forecast.city.name, comment: "") 
        _daysTableView.reloadData()
    }
    
    func updateCurrentWeather(_ weather: CurrentWeather)
    {
        _weatherImage.image = UIImage(named: weather.weatherSummary.iconId)
        _weatherSummaryLabel.text = NSLocalizedString(weather.weatherSummary.description, comment: "") + ", " + weather.weatherDetails.temp.description
    }
    
    // MARK: - Private methods
    
    /// Configures view and its subviews with their constraints
    private func _init()
    {
        backgroundColor = UIColor.cyan
        
        // setup components
        
        _weatherImage = UIImageView(frame: CGRect.zero)
        addSubview(_weatherImage)
        
        _daysTableView = UITableView(frame: CGRect.zero, style: .plain)
        _daysTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherView.REUSE_IDENTIFIER)
        _daysTableView.dataSource = self
        _daysTableView.delegate = self
        addSubview(_daysTableView)
        
        _cityLabel = UILabel(frame: CGRect.zero)
        _cityLabel.textColor = UIColor.white
        _cityLabel.font = _cityLabel.font.withSize(60)
        _cityLabel.adjustsFontSizeToFitWidth = true
        _cityLabel.minimumScaleFactor = 0.1
        _cityLabel.textAlignment = .center
        _cityLabel.baselineAdjustment = .alignCenters
        addSubview(_cityLabel)
        
        _weatherSummaryLabel = UILabel(frame: CGRect.zero)
        _weatherSummaryLabel.textColor = UIColor.white
        _weatherSummaryLabel.font = _weatherSummaryLabel.font.withSize(48)
        _weatherSummaryLabel.adjustsFontSizeToFitWidth = true
        _weatherSummaryLabel.minimumScaleFactor = 0.1
        _weatherSummaryLabel.textAlignment = .center
        _weatherSummaryLabel.baselineAdjustment = .alignCenters
        addSubview(_weatherSummaryLabel)
        
        // init constraints
        
        _cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32)
            make.height.equalTo(88)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        _weatherSummaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(_cityLabel.snp.bottom).inset(-8)
            make.height.equalTo(48)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        _weatherImage.snp.makeConstraints { make in
            make.top.equalTo(_weatherSummaryLabel.snp.bottom)
            make.centerX.equalToSuperview()
            
            make.bottom.equalTo(_daysTableView.snp.top)
            make.width.equalTo(_weatherImage.snp.height)
        }
        
        _daysTableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    // MARK: - Private static constants
    
    private static let REUSE_IDENTIFIER = "weather_table_id"
    
    // MARK: - Private properties
    
    private var _forecast: WeatherForecast? = nil
    
    private var _weatherImage: UIImageView! = nil
    private var _daysTableView: UITableView! = nil
    private var _cityLabel: UILabel! = nil
    private var _weatherSummaryLabel: UILabel! = nil
    
    private weak var _vc: WeatherViewController! = nil
    
}

// MARK: - UITableViewDataSource implementation

extension WeatherView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherView.REUSE_IDENTIFIER, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        if let item = _forecast?.days[indexPath.row * 8]
        {
            cell.show(dayPartForecast: item)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate implementation

extension WeatherView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        _vc.didSelectDay(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
