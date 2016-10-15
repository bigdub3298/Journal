//
//  Stack.swift
//  Journal
//
//  Created by Wesley Austin on 10/15/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData

class Stack {
    static var sharedStack = Stack()
    
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() ->  NSManagedObjectContext {
        let bundle = NSBundle.mainBundle()
        
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle]) else {
            fatalError("Model not found")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        try! psc.addPersistentStoreWithType(NSSQLiteStoreType,
                                            configuration: nil,
                                            URL: storeURL(),
                                            options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferredMappingModelError: true])
        
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        return context
    }
    
    static func storeURL() -> NSURL? {
        let documentDirectory = try? NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
        
        return documentDirectory?.URLByAppendingPathComponent("db.sqlite")
    }
    
    static func saveToPersistentStore() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Model. Items not saved")
        }
    }
}
