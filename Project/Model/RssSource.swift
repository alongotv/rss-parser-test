//
//  RssSource.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 05/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import Foundation
import CoreData

struct RssSourceObject{
    var sourceName: String
    var sourceLink: String
    var isFavourite: Bool
}

public class RssSource: NSManagedObject{
    @NSManaged var sourceName: String
    @NSManaged var sourceLink: String
    @NSManaged var isFavourite: Bool
    
    var source: RssSourceObject {
        
        get {
            return RssSourceObject(sourceName: self.sourceName, sourceLink: self.sourceLink, isFavourite: self.isFavourite)
        }
        
        set {
            self.sourceName = newValue.sourceName
            self.sourceLink = newValue.sourceLink
            self.isFavourite = newValue.isFavourite
        }
    }
}
