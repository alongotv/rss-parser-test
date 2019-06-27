//
//  Persistence.swift
//  rss-parser-test
//
//  Created by Vladimir Vetrov on 01/05/2019.
//  Copyright © 2019 Vladimir Vetrov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Persistence {
    
    func fetchSourcesFromCoreData()-> Array<RssSource> {
        var sources = [RssSource]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RssSource>(entityName: "RssSource")

        do {
            sources = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return sources
    }
    
    func removeObjectFromCoreData(source: RssSource) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RssSource")
        request.predicate = NSPredicate(format:"sourceLink = %@", source.sourceLink!)
        
        let result = try? managedContext.fetch(request)
        let resultData = result as! [NSManagedObject]
        
        managedContext.delete(resultData[0])
        
        do {
            try managedContext.save() }
        catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func saveSourceToCoreData(name: String, link: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RssSource", in: managedContext)!
        let source = RssSource(entity: entity, insertInto: managedContext)
        
        source.setValue(false, forKey: "isFavourite")
        source.sourceName = name
        source.sourceLink = link
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
