//
//  CCData.swift
//  CCData
//
//  Created by Henry Tseng (tuzaiz) on 2014/11/21.
//  Copyright (c) 2014 Cloudbay. All rights reserved.
//

import Foundation
import CoreData

struct ConciseCore {
    
    static var databaseFileName : String? = "database.sqlite"
    
    static func setupDatabaseName(name:String) {
        databaseFileName = name
    }
    
    static var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }
    
    static var managedObjectModel: NSManagedObjectModel? {
        return NSManagedObjectModel.mergedModelFromBundles(nil)
    }
    
    static var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        let url = applicationDocumentsDirectory.URLByAppendingPathComponent(databaseFileName!)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            abort()
        }
        
        return coordinator
    }
    
    static var rootSaveContext : NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
        }()
    
    static var managedObjectContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.parentContext = rootSaveContext
        return context
        }()
    
}

