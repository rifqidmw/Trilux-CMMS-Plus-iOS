//
//  NSPersistentContainer+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/01/24.
//

import CoreData

extension NSPersistentContainer {
    
    static func named(_ name: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }
    
}
