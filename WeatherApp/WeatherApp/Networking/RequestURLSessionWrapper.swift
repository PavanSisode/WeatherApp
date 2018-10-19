//
//  RequestURLSessionWrapper.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
class RequestURLSessionWrapper: RequestProtocol {
    
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: callback)
        task.resume()
    }
}
