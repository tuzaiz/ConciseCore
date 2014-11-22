//
//  TZTable.swift
//  CloudCore
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func entityName() -> String {
        let className : String = NSStringFromClass(self) as String
        return className.self.componentsSeparatedByString(".")[1]
    }
}

class CCTable<T:NSManagedObject> {
    var context : NSManagedObjectContext
    var entityName : String
    init(context:NSManagedObjectContext) {
        self.context = context
        self.entityName = T.entityName()
    }
    
    func create(attributes : Dictionary<String, AnyObject>) -> T {
        var newEntity : T = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as T
        for (key, val) in attributes {
            if newEntity.respondsToSelector(Selector(key)) {
                newEntity.setValue(val, forKey: key)
            }
        }
        return newEntity
    }
    
    func all() -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        return self.context.executeFetchRequest(fetchRequest, error: nil) as? [T]
    }
    
    func all(limit:Int, offset:Int) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        return self.context.executeFetchRequest(fetchRequest, error: nil) as? [T]
    }
    
    func first(sort : [NSSortDescriptor]?) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.sortDescriptors = sort
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    func last(sort : [NSSortDescriptor]?) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.sortDescriptors = sort
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.last as? T
        }
        return nil
    }
    
    func take() -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    func findBy(#attribute:String, value:AnyObject) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    func findBy(#format:String, values:AnyObject...) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: format, argumentArray: values)
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    func findAllBy(#attribute:String, value:AnyObject) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error) as? [T]
        return results
    }
    
    func findAllBy(#format:String, values:AnyObject...) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: format, argumentArray: values)
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error) as? [T]
        return results
    }
    
    func count() -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
    
    func countBy(#attribute:String, value:AnyObject) -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
    
    func countBy(#format:String, values:AnyObject...) -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: format, argumentArray: values)
        fetchRequest.predicate = predicate
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
}