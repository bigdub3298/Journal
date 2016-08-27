//
//  Entry.swift
//  Journal
//
//  Created by Wesley Austin on 8/20/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation

class Entry: NSObject, NSCoding {
    var title: String
    var bodyText: String
    var timeStamp: NSDate
    
    init(title: String, bodyText: String, timeStamp: NSDate) {
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
    }
    
    // Mark: - Types
    struct PropertyKey {
        static let titleKey = "title"
        static let bodyTextKey = "bodyText"
        static let timeStampKey = "timeStamp"
    }
    
    // Mark: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(bodyText, forKey: PropertyKey.bodyTextKey)
        aCoder.encodeObject(timeStamp, forKey: PropertyKey.timeStampKey)
    }
    
    required convenience init?(coder aCoder: NSCoder) {
        let title = aCoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let bodyText = aCoder.decodeObjectForKey(PropertyKey.bodyTextKey) as! String
        let timeStamp = aCoder.decodeObjectForKey(PropertyKey.timeStampKey) as! NSDate
        
        self.init(title: title, bodyText: bodyText, timeStamp: timeStamp)
        
    }
}


// Implementation of Equatable Protocol 
func ==(lhs: Entry, rhs: Entry) -> Bool {
    return (lhs.title == rhs.title) && (lhs.bodyText == rhs.bodyText) && (lhs.timeStamp == lhs.timeStamp)
}


