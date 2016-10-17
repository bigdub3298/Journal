//
//  Journal.swift
//  Journal
//
//  Created by Wesley Austin on 10/16/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class Journal: NSManagedObject {

    static let className = "Journal"
    
    convenience init(title: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName(Journal.className, inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
    }

}
