//
//  Journal.swift
//  Journal
//
//  Created by Wesley Austin on 8/23/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation

class Journal: NSObject, NSCoding {
    
    var entries: [Entry]
    var title: String
    
    init(title: String, entries: [Entry]) {
        self.title = title
        self.entries = entries
    }
    
    // MARK: - Types
    struct PropertyKeys {
        static let title = "title"
        static let entries = "entries"
    }
    
    
    // MARK: - NSCoding 
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKeys.title)
        aCoder.encodeObject(entries, forKey: PropertyKeys.entries)
    }
    
    required convenience init?(coder aCoder: NSCoder) {
        let title = aCoder.decodeObjectForKey(PropertyKeys.title) as! String
        let entries = aCoder.decodeObjectForKey(PropertyKeys.entries) as! [Entry]
        
        self.init(title: title, entries: entries)
    }
}

func ==(lhs: Journal, rhs: Journal) -> Bool {
    return lhs.title == rhs.title && lhs.entries == rhs.entries
}