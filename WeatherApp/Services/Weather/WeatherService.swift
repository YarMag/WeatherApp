//
//  WeatherService.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import Foundation
import Alamofire

/// Service to retrieve weather data.
class WeatherService
{
    weak var delegate: WeatherServiceDelegate? = nil
    
    init(apiKey: String)
    {
        _apiKey = apiKey
    }
    
    // api key required to send requests
    private var _apiKey: String
}

// MARK: - WeatherServiceProtocol implementation
extension WeatherService: WeatherServiceProtocol
{
    // MARK: Protocol methods
    
    func requestWeatherForecast(forLatitude lat: Double, withLongitude lon: Double)
    {
        guard let urlRequest = _buildWeatherForecastUrlRequest(latitude: lat, longtitude: lon) else { return }
        
        _executeForecastRequest(urlRequest: urlRequest)
    }
    
    func requestCurrentWeather(forLatitude lat: Double, withLongitude lon: Double)
    {
        guard let urlRequest = _buildCurrentWeatherUrlRequest(latitude: lat, longitude: lon) else { return }
        
        _executeCurrentWeatherRequest(urlRequest: urlRequest)
    }
    
    // MARK: Private methods
    
    private func _buildWeatherForecastUrlRequest(latitude: Double, longtitude: Double) -> URLRequest?
    {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longtitude)&APPID=\(_apiKey)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    private func _buildCurrentWeatherUrlRequest(latitude: Double, longitude: Double) -> URLRequest?
    {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(_apiKey)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    private func _executeForecastRequest(urlRequest: URLRequest)
    {
        AF.request(urlRequest).responseJSON { [unowned self] response in
            
            guard let data = response.data else { return }
            guard let jsonResponse = self._parseJsonResponse(data: data) else { return }
            
            self._onForecastLoaded(json: jsonResponse)
        }
    }
    
    private func _executeCurrentWeatherRequest(urlRequest: URLRequest)
    {
        AF.request(urlRequest).responseJSON { [unowned self] response in
            
            guard let data = response.data else { return }
            guard let jsonResponse = self._parseJsonResponse(data: data) else { return }
            
            self._onCurrentWeatherLoaded(json: jsonResponse)
        }
    }
    
    /// Parses specified data as JSON and returns result
    private func _parseJsonResponse(data: Data) -> Any?
    {
        var jsonResponse: Any? = nil
        
        do
        {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch let parsingError
        {
            print(parsingError.localizedDescription)
        }
        
        return jsonResponse
    }
    
    private func _onForecastLoaded(json: Any)
    {
        guard let forecastJSON = json as? [String: Any] else { return }
        guard let weatherForecast = WeatherForecast(withJSON: forecastJSON) else { return }
        delegate?.didLoadForecast(weatherForecast)
    }
    
    private func _onCurrentWeatherLoaded(json: Any)
    {
        guard let weatherJSON = json as? [String: Any] else { return }
        guard let weather = CurrentWeather(withJSON: weatherJSON) else { return }
        delegate?.didLoadCurrentWeather(weather)
    }
}
