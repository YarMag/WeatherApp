//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 02/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit

/// Manages weather forecast view.
class WeatherViewController: UIViewController
{
    init(viewModel: WeatherViewModelProtocol)
    {
        super.init(nibName: nil, bundle: nil)
        
        _viewModel = viewModel
        _viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override UIViewController methods
    
    override func loadView() {
        let weatherView = WeatherView(viewController: self)
        
        self.view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _viewModel.requestWeatherForecast()
        _viewModel.requestCurrentWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Public methods
    
    func didSelectDay(index: Int)
    {
        _viewModel.onDaySelected(dayIndex: index)
    }
    
    // MARK: - Private properties
    
    private var _viewModel: WeatherViewModelProtocol! = nil
}

// MARK: - WeatherViewModelDelegate implementation

extension WeatherViewController: WeatherViewModelDelegate
{
    func didLoadForecast(forecast: WeatherForecast)
    {
        guard let weatherView = self.view as? WeatherView else { return }
        
        DispatchQueue.main.async {
            weatherView.updateForecast(forecast)
        } 
    }
    
    func didLoadCurrentWeather(weather: CurrentWeather)
    {
        guard let weatherView = self.view as? WeatherView else { return }
        
        DispatchQueue.main.async {
            weatherView.updateCurrentWeather(weather)
        }
    }
    
    func presentDayForecast(dayForecast: [DayPartForecast])
    {
        let dayVC = DayViewController(dayForecast: dayForecast)
        self.navigationController?.pushViewController(dayVC, animated: true)
    }
}
