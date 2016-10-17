//
//  Entry.swift
//  Journal
//
//  Created by Wesley Austin on 10/16/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class Entry: NSManagedObject {

    static let className = "Entry"
    
    convenience init(title: String, bodyText: String, timeStamp: NSDate, journal: Journal, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName(Entry.className, inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
        self.journal = journal 
    }

}
