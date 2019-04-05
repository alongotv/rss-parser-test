//
//  RssSource.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 05/04/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import Foundation
import CoreData

struct RssSource{
    var sourceName: String
    var sourceLink: String
}

class FavouriteSource: NSManagedObject{
    @NSManaged var sourceName: String
    @NSManaged var sourceLink: String
    
    var source: RssSource {
        
        get {
            return RssSource(sourceName: self.sourceName, sourceLink: self.sourceLink)
        }
        
        set {
            self.sourceName = newValue.sourceName
            self.sourceLink = newValue.sourceLink
        }
    }
}
