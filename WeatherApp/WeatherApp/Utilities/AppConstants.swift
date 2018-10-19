//
//  AppConstants.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
import UIKit

class AppConstants {
    
    static let baseUrl = "https://s3.eu-west-2.amazonaws.com/interview-question-data/metoffice/"
    static let genericErrorMessage = "Something went wrong."
    static let invalidURL = "Invalid URL"
    static let connectionError = "Please check your network connection!"
    
    // MARK: - UI Constants
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidthForScaling:CGFloat = 375.0
    static let screenHeightForScaling:CGFloat = 667.0
}

enum ParamType: String {
    case UK = "UK"
    case EN = "England"
    case SCO = "Scotland"
    case WA = "Wales"
    
    case Tmax = "Max temperature"
    case Tmin = "Min temperature"
    case Rainfall = "Rainfall"
}

struct Parameter {
    var metric: ParamType = .Tmax
    var location: ParamType = .EN
    var isReadyToSet: Bool = false
}
