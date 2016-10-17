//
//  Entry+CoreDataProperties.swift
//  Journal
//
//  Created by Wesley Austin on 10/16/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var title: String?
    @NSManaged var bodyText: String?
    @NSManaged var timeStamp: NSDate?
    @NSManaged var journal: NSManagedObject?

}
