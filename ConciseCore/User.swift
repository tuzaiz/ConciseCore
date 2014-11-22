//
//  User.swift
//  TZData
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var age: NSNumber

}
