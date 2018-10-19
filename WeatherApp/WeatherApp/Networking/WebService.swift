//
//  WebService.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation

protocol WebService {
    typealias WeatherDataCallback = (([WeatherData]?, String?) -> Void)
    func getWeatherData(param: Parameter, callback: @escaping WeatherDataCallback)
}
