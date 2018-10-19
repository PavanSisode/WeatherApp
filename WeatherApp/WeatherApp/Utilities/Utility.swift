//
//  Utility.swift
//  WeatherApp
//
//  Created by Pavan Shisode on 18/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Utility {
    static func showAlert(message: String, delegate: UIViewController) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        delegate.present(alertController, animated: true, completion: nil)
    }
    
    static func save(moc: NSManagedObjectContext) {
        do {
            try moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
