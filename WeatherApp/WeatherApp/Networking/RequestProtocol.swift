//
//  RequestProtocol.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
// A protocol for making network requests

protocol RequestProtocol {
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}

