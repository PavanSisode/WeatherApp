//
//  MonthDataModel.swift
//  WeatherApp
//
//  Created by Pavan on 19/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
import CoreData

extension Month {
    private static func takeNewEntity(moc: NSManagedObjectContext) ->Month? {
        return NSEntityDescription.insertNewObject(forEntityName: "Month", into: moc) as? Month
    }
    
    private class func existingMonth(weather: WeatherData, with moc: NSManagedObjectContext) -> Month? {
        let fetchRequest: NSFetchRequest<Month> = Month.fetchRequest()
        let predicate = NSPredicate(format: "monthNumber == %d AND year.yearNumber == %d", weather.month!, weather.year! )
        fetchRequest.predicate = predicate
        do {
            let searchResult = try moc.fetch(fetchRequest)
            if(searchResult.count > 0) {
                let month = searchResult[0] as Month
                return month
            }
            return nil
        } catch {
            print("Failed")
        }
        return nil
    }
    
    class func createMonth(year: Year?, from weather: WeatherData, with moc: NSManagedObjectContext) {
        
        guard let monthNumber = weather.month, monthNumber > 0, let lyear = year else {
            return
        }
        
        var month = Month.existingMonth(weather: weather, with: moc)
        if month == nil {
            month = Month.takeNewEntity(moc: moc)
        }
        
        if let mon = weather.month {
            month?.monthNumber = mon
        }
        
        if let val = weather.value {
            month?.monthValue = val
        }
        
        lyear.addToMonths(month!)
        Utility.save(moc: moc)
    }
    
    class func fetchMonthsForYear(year: Year, moc: NSManagedObjectContext)-> [Month]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Month")
        let predicate = NSPredicate(format: "year.yearNumber == %d", year.yearNumber)
        let sortDescriptor = NSSortDescriptor(key: "monthNumber", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try moc.fetch(request)
            if result.isEmpty {
                return nil
            }
            return result as? [Month]
        } catch {
            print("Failed")
        }
        return nil
    }
    
    class func fetchMonths(moc: NSManagedObjectContext)-> [Month]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Month")
        request.returnsObjectsAsFaults = false
        do {
            let result = try moc.fetch(request)
            if result.isEmpty {
                return nil
            }
            return result as? [Month]
        } catch {
            print("Failed")
        }
        return nil
    }
}
