//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var month: Int64?
    var year: Int64?
    var value: Double?
}

class WeatherAPI: WebService {
    private let requestProtocol: RequestProtocol
    
    init(requestProtocol: RequestProtocol = RequestURLSessionWrapper()) {
        self.requestProtocol = requestProtocol
    }
    
    func getWeatherData(param: Parameter, callback: @escaping WebService.WeatherDataCallback) {
        let urlString = AppConstants.baseUrl + "\(param.metric)-\(param.location.rawValue).json"
        guard let url = URL(string: urlString) else {
            callback(nil, AppConstants.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        requestProtocol.makeRequest(request: request) { (data, response, error) in
            guard let jsonData = data else {
                callback(nil, error?.localizedDescription)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherData = try decoder.decode([WeatherData].self, from: jsonData)
                callback(weatherData, nil)
            } catch let error {
                print("Error", error)
                 callback(nil,error.localizedDescription)
            }
        }
    }
}
