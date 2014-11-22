//
//  TZSchema.swift
//  CloudCore
//
//  Created by Henry on 2014/11/22.
//  Copyright (c) 2014年 Cloudbay. All rights reserved.
//

import Foundation

extension CCDB {
    var user : CCTable<User> { return CCTable(context: context) }
}