//
//  ToDoItem.swift
//  2Do
//
//  Created by Talor Hammond on 26/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var completed: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // establishing child-parent relationship:
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
