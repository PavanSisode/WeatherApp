//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Pavan on 19/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
import CoreData

class DashboardViewModel {
    var reloadList = { () -> Void in }
    var reachability: ((String) -> Void)?
    var currentSection: Int = 0
    var currentCollectionViewRow: Int = 0
    
    var yearArray = [Year]() {
        didSet {
            self.reloadList()
        }
    }
    var paramObject = Parameter()
    private let weatherAPI: WebService
    
    init(api: WebService = WeatherAPI()) {
        weatherAPI = api
    }
    
    func setLocationString() -> String {
        return paramObject.location.rawValue
    }
    
    func setMetricString() -> String {
        return paramObject.metric.rawValue
    }
    
    func setYearString() -> String {
        return "Year: \(yearArray[currentSection].yearNumber)"
    }
    
    func setMonthName() -> String {
        guard let months = Month.fetchMonthsForYear(year: yearArray[currentSection], moc: yearArray[currentSection].managedObjectContext!) else {
            return "N/A"
        }
        
        let month = months[currentCollectionViewRow]
        
        switch month.monthNumber {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return  "Nov"
        case 12:
            return "Dec"
        default:
            return "N/A"
        }
    }
    
    func setMonthValue() -> String {
        guard let month: Month = yearArray[currentSection].months!.allObjects[currentCollectionViewRow] as? Month else {
            return "N/A"
        }
        return "\(month.monthValue)"
    }
    
    func numberOfSections() -> Int {
        return yearArray.count
    }
    
    func numberOfRowsForCollectionView(section: Int) -> Int {
        return yearArray[section].months?.count ?? 0
    }
}

extension DashboardViewModel {
    func prepareToCallWeatherAPI(moc: NSManagedObjectContext) {
        if Network.connectedToNetwork() {
            self.callWeatherAPI(param:self.paramObject, moc: moc)
        } else {
            self.reachability!(AppConstants.connectionError)
        }
    }
    
    private func callWeatherAPI(param:Parameter, moc: NSManagedObjectContext) {
        weatherAPI.getWeatherData(param: param) { (weatherData, message) in
            guard let weatherArray = weatherData else {
                return
            }
            
            Year.deleteAllRecords(moc: moc)
            
            for weather in weatherArray {
                Year.createYear(from: weather, with: moc)
            }
            
            if let years = Year.fetchYears(moc: moc) {
                self.yearArray = years
            } else {
                self.yearArray = []
            }
        }
    }
}

