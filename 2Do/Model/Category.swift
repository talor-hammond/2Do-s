//
//  Category.swift
//  2Do
//
//  Created by Talor Hammond on 26/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    // establishing parent-child relationship (one-to-many):
    let items = List<ToDoItem>()
}

