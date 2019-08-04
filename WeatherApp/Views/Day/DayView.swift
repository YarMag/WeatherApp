//
//  DayView.swift
//  WeatherApp
//
//  Created by  Магин Ярослав on 04/08/2019.
//  Copyright © 2019 Magin Yaroslav. All rights reserved.
//

import UIKit
import SnapKit

/// Shows weather data for specified day.
class DayView: UIView
{
    init(dayForecast: [DayPartForecast])
    {
        super.init(frame: CGRect.zero)
        
        _dayForecast = dayForecast
        _init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    /// Configures view and its subviews with their constraints.
    private func _init()
    {
        backgroundColor = UIColor.cyan
        
        // setup components
        
        let dateLabel = DayViewLabel(frame: CGRect.zero)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.1
        dateLabel.font = dateLabel.font.withSize(48)
        addSubview(dateLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        dateFormatter.locale = .current
        dateLabel.text = dateFormatter.string(from: _dayForecast[0].dateTime)
        
        // init constraints
        
        _forecastTableView = UITableView(frame: CGRect.zero, style: .plain)
        _forecastTableView.register(DayTableViewCell.self, forCellReuseIdentifier: DayView.REUSE_IDENTIFIER)
        _forecastTableView.dataSource = self
        _forecastTableView.allowsSelection = false
        addSubview(_forecastTableView)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(74)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(66)
            make.trailing.equalToSuperview().inset(8)
        }
        
        _forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(-16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Private constants
    
    private static let REUSE_IDENTIFIER = "days_table_id"
    
    // MARK: - Private fields
    
    private var _forecastTableView: UITableView! = nil
    private var _dayForecast: [DayPartForecast]! = nil
}

// MARK: - UITableViewDataSource implementation

extension DayView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return _dayForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayView.REUSE_IDENTIFIER, for: indexPath) as? DayTableViewCell else { return UITableViewCell() }
        
        cell.show(dayPartForecast: _dayForecast[indexPath.row])
        
        return cell
    }
}
