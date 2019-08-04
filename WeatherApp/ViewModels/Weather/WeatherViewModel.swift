//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation
import CoreLocation

/// ViewModel manages weather forecast and its services
class WeatherViewModel: NSObject, CLLocationManagerDelegate
{
    weak var delegate: WeatherViewModelDelegate? = nil
    
    init(withWeatherService service: WeatherServiceProtocol)
    {
        super.init()
        
        _weatherService = service
        _weatherService.delegate = self
        
        _enableLocationManager()
    }
    
    // MARK: - Private methods
    
    private func _enableLocationManager()
    {
        _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        _locationManager.requestWhenInUseAuthorization()
        
        _locationManager.startUpdatingLocation()
    }
    
    // MARK: - Private fields
    
    private var _currentForecast: WeatherForecast? = nil
    private var _locationManager: CLLocationManager!
    private var _weatherService: WeatherServiceProtocol!
}

// MARK: - WeatherViewModelProtocol implementation

extension WeatherViewModel: WeatherViewModelProtocol
{
    func requestWeatherForecast()
    {
        // request forecast based on current location
        guard let location = _locationManager.location else { return }
        
        _weatherService.requestWeatherForecast(forLatitude: location.coordinate.latitude, withLongitude: location.coordinate.longitude)
    }
    
    func requestCurrentWeather()
    {
        // request forecast based on current location
        guard let location = _locationManager.location else { return }
        
        _weatherService.requestCurrentWeather(forLatitude: location.coordinate.latitude, withLongitude: location.coordinate.longitude)
    }
    
    func onDaySelected(dayIndex: Int)
    {
        guard let forecast = _currentForecast else { return }
        
        // calculate exact calendar day for which data will be shown
        guard let targetDay = Calendar.current.date(byAdding: .day, value: dayIndex, to: forecast.days[0].dateTime) else { return }
        
        // filters only forecast parts relevant to requested day
        let dayForecast = forecast.days.filter { item in
            Calendar.current.compare(item.dateTime, to: targetDay, toGranularity: .day) == .orderedSame
        }
        
        delegate?.presentDayForecast(dayForecast: dayForecast)
    }
    
}

// MARK: - WeatherServiceDelegate implementation

extension WeatherViewModel: WeatherServiceDelegate
{
    func didLoadForecast(_ forecast: WeatherForecast)
    {
        _currentForecast = forecast
        
        delegate?.didLoadForecast(forecast: forecast)
    }
    
    func didLoadCurrentWeather(_ weather: CurrentWeather)
    {
        delegate?.didLoadCurrentWeather(weather: weather)
    }
}
