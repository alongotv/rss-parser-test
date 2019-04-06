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
    var isFavouriteSource: Bool
}

class RssSourceObject: NSManagedObject{
    @NSManaged var sourceName: String
    @NSManaged var sourceLink: String
    @NSManaged var isFavouriteSource: Bool
    
    var source: RssSource {
        
        get {
            return RssSource(sourceName: self.sourceName, sourceLink: self.sourceLink, isFavouriteSource: self.isFavouriteSource)
        }
        
        set {
            self.sourceName = newValue.sourceName
            self.sourceLink = newValue.sourceLink
            self.isFavouriteSource = newValue.isFavouriteSource
        }
    }
}
