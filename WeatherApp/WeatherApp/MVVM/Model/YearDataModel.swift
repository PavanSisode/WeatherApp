//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Pavan on 19/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import Foundation
import CoreData

extension Year {
    private static func takeNewEntity(moc: NSManagedObjectContext) ->Year? {
        return NSEntityDescription.insertNewObject(forEntityName: "Year", into: moc) as? Year
    }
    
    private class func existingYear(weather: WeatherData, with moc: NSManagedObjectContext) -> Year? {
        let fetchRequest: NSFetchRequest<Year> = Year.fetchRequest()
        let predicate = NSPredicate(format: "yearNumber == %d", weather.year! )
        fetchRequest.predicate = predicate
        do {
            let searchResult = try moc.fetch(fetchRequest)
            if(searchResult.count > 0) {
                let year = searchResult[0] as Year
                return year
            }
            return nil
        } catch {
            print("Failed")
        }
        return nil
    }
    
    class func createYear(from weather: WeatherData, with moc: NSManagedObjectContext) {
        
        guard let yearNumber = weather.year, yearNumber > 0 else {
            return
        }
        
        var year = Year.existingYear(weather: weather, with: moc)
        if year == nil {
            year = Year.takeNewEntity(moc: moc)
        }
        
        year?.yearNumber = weather.year ?? 0
        Month.createMonth(year: year, from: weather, with: moc)
        Utility.save(moc: moc)
    }
    
    class func fetchYears(moc: NSManagedObjectContext)-> [Year]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Year")
        request.returnsObjectsAsFaults = false
        do {
            let result = try moc.fetch(request)
            if result.isEmpty {
                return nil
            }
            return result as? [Year]
        } catch {
            print("Failed")
        }
        return nil
    }
    
    static func deleteAllRecords(moc: NSManagedObjectContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Year")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try moc.execute(deleteRequest)
            Utility.save(moc: moc)
        } catch {
            print ("There is an error in deleting records")
        }
    }
}

