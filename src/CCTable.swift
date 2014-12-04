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
        let classComponent = className.self.componentsSeparatedByString(".")
        if classComponent.count > 1 {
            return className.self.componentsSeparatedByString(".")[1]
        } else {
            return className
        }
    }
    
    internal func delete() {
        self.managedObjectContext?.deleteObject(self)
    }
    
    internal func refresh(mergeChanges : Bool) {
        self.managedObjectContext?.refreshObject(self, mergeChanges: mergeChanges)
    }
}

class CCTable<T:NSManagedObject> {
    var context : NSManagedObjectContext
    var entityName : String
    init(context:NSManagedObjectContext) {
        self.context = context
        self.entityName = T.entityName()
    }
    
    internal func create(attributes : Dictionary<String, AnyObject>) -> T {
        var newEntity : T = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as T
        for (key, val) in attributes {
            if newEntity.respondsToSelector(Selector(key)) {
                newEntity.setValue(val, forKey: key)
            }
        }
        return newEntity
    }
    
    internal func all() -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        return self.context.executeFetchRequest(fetchRequest, error: nil) as? [T]
    }
    
    internal func all(limit:Int, offset:Int) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        return self.context.executeFetchRequest(fetchRequest, error: nil) as? [T]
    }
    
    internal func first(sort : [NSSortDescriptor]?) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.sortDescriptors = sort
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    internal func last(sort : [NSSortDescriptor]?) -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        fetchRequest.sortDescriptors = sort
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.last as? T
        }
        return nil
    }
    
    internal func take() -> T? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var results = self.context.executeFetchRequest(fetchRequest, error: &error)
        if error == nil && results?.count > 0 {
            return results?.first as? T
        }
        return nil
    }
    
    internal func findBy(#attribute:String, value:AnyObject) -> T? {
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
    
    internal func findBy(#format:String, values:AnyObject...) -> T? {
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
    
    internal func findAllBy(#attribute:String, value:AnyObject) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error) as? [T]
        return results
    }
    
    internal func findAllBy(#format:String, values:AnyObject...) -> [T]? {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: format, argumentArray: values)
        fetchRequest.predicate = predicate
        var results = self.context.executeFetchRequest(fetchRequest, error: &error) as? [T]
        return results
    }
    
    internal func count() -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
    
    internal func countBy(#attribute:String, value:AnyObject) -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
    
    internal func countBy(#format:String, values:AnyObject...) -> Int {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: format, argumentArray: values)
        fetchRequest.predicate = predicate
        return self.context.countForFetchRequest(fetchRequest, error: &error)
    }
    
    internal func exists(#attribute:String, value:AnyObject) -> Bool {
        var fetchRequest = NSFetchRequest(entityName: self.entityName)
        var error : NSError?
        var predicate = NSPredicate(format: "\(attribute)=%@", argumentArray: [value])
        fetchRequest.predicate = predicate
        return self.context.countForFetchRequest(fetchRequest, error: &error) > 0
    }
}