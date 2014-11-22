//
//  TZDB.swift
//  CloudCore
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation
import CoreData

class CCDB {
    lazy var context : NSManagedObjectContext = {
        var ctx = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        ctx.parentContext = ConciseCore.managedObjectContext
        return ctx
    }()
    
    func save() {
        var error : NSError?
        self.context.save(&error)
        ConciseCore.managedObjectContext.save(&error)
        ConciseCore.rootSaveContext.save(&error)
    }
}