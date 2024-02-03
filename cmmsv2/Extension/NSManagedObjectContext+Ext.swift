//
//  NSManagedObjectContext+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/01/24.
//

import CoreData
import UIKit

extension NSManagedObjectContext {
    
    func saveToCoreData<T: NSManagedObject>(_ entityName: String, data: [String: Any]) -> T? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            return nil
        }
        
        let newObject = T(entity: entityDescription, insertInto: self)
        
        for (key, value) in data {
            newObject.setValue(value, forKey: key)
        }
        
        do {
            try self.save()
            return newObject
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func fetchFromCoreData<T: NSManagedObject>(_ entityName: String, predicate: NSPredicate? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        do {
            let result = try self.fetch(fetchRequest)
            return result
        } catch let error as NSError {
            print("Error fetching data from Core Data. \(error), \(error.userInfo)")
            return []
        }
    }
    
}
