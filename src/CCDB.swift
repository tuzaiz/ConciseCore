//
//  TZDB.swift
//  CloudCore
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation
import CoreData

class CCDB : NSObject {
    lazy var context : NSManagedObjectContext = {
        var ctx = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        ctx.parentContext = ConciseCore.managedObjectContext
        return ctx
    }()

    internal func save() {
        var error : NSError?
        self.context.performBlockAndWait { () -> Void in
            self.saveToContext(&error)
        }
    }

    internal func save(completion:((NSError?) -> Void)?) {
        self.context.performBlock { () -> Void in
            var error  : NSError?
            self.context.performBlock({ () -> Void in
                self.saveToContext(&error)
                if let complete = completion {
                    complete(error)
                }
            })
        }
    }

    private func saveToContext(error:NSErrorPointer?) {
        var error : NSError?
        self.context.save(&error)
        var ctx : NSManagedObjectContext? = self.context
        while var context = ctx?.parentContext {
            context.save(&error)
            ctx = context
        }
    }

    internal func remove(itemId:NSManagedObjectID) {
        var item = self.context.objectWithID(itemId) as NSManagedObject
        self.context.deleteObject(item)
        self.save();
    }
}