//
//  JournalController.swift
//  Journal
//
//  Created by Wesley Austin on 8/23/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation

class JournalController {
    static let sharedController = JournalController()
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("journals")
    
    // Read
    var journals: [Journal]
    
    init() {
        self.journals = []
    }
    
    // Create
    func addJournal(journal: Journal) {
        journals.append(journal)
    }
    
    // Delete 
    func deleteJournal(journal: Journal) {
        if let index = journals.indexOf(journal) {
            journals.removeAtIndex(index)
        }
    }
    
    // Update 
        // use dot syntax and properties 
    
    
    // MARK: - NSCoding
    func saveJournals() {
        let isSuccesfullSave = NSKeyedArchiver.archiveRootObject(JournalController.sharedController.journals, toFile: JournalController.ArchiveURL.path!)
        
        if !isSuccesfullSave {
            print("Failed to save entries...")
        }
    }
    
    func loadJournals() -> [Journal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(JournalController.ArchiveURL.path!) as? [Journal]
    }
    
}