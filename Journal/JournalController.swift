//
//  JournalController.swift
//  Journal
//
//  Created by Wesley Austin on 10/16/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class JournalController {
    static let sharedController = JournalController()
    
    // Read
    var journals: [Journal] {
        let request = NSFetchRequest(entityName: Journal.className)
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            return try moc.executeFetchRequest(request) as! [Journal]
        } catch {
            return []
        }
    }
    
    // Create
    func addJournal(title: String) {
        let _ = Journal(title: title)
        Stack.saveToPersistentStore()
    }
    
    // Delete
    func removeJournal(journal: Journal) {
        if let moc = journal.managedObjectContext {
            moc.deleteObject(journal)
            Stack.saveToPersistentStore()
        }
    }
    
    // Update 
    func updateJournal(journal: Journal, title: String) {
        journal.title = title
        Stack.saveToPersistentStore()
    }
    
    // Add Entry
    func addEntryToJournal(title: String, bodyText: String, journal: Journal) {
        let _ = Entry(title: title, bodyText: bodyText, timeStamp: NSDate(), journal: journal)
        Stack.saveToPersistentStore()
    }
    
    // Remove Entry
    func removeEntryFromJournal(entry: Entry) {
        if let moc = entry.managedObjectContext {
            moc.deleteObject(entry)
            Stack.saveToPersistentStore()
        }
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String) {
        entry.title = title
        entry.bodyText = bodyText
        Stack.saveToPersistentStore()
    }
}