//
//  Healing.swift
//  Healings
//:String
//  Created by Jonathan on 2/15/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import Parse

struct Healing {
    var userName: String?
    var anon: Bool
    var title: String
    var body: String
    var createdAt: Date
    var updatedAt: Date
    
    // This constructor is for: A non-anonymous public healing
    init(userName: String, anon: Bool, title: String, body: String, createdAt: Date, updatedAt: Date) {
        
        self.userName = userName
        self.anon = anon
        self.title = title
        self.body = body
        self.createdAt = createdAt as Date
        self.updatedAt = updatedAt as Date
    }
    
    // This constructor is for: An anonymous public healing
    init(anon: Bool, title: String, body: String, createdAt: Date, updatedAt: Date) {
        
        self.anon = anon
        self.title = title
        self.body = body
        self.createdAt = createdAt as Date
        self.updatedAt = updatedAt as Date
    }
}
