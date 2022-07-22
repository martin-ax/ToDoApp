//
//  Item.swift
//  Todoey
//
//  Created by Martin Arellano on 7/16/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: String = ""
    var parentCategory = LinkingObjects<Category>(fromType: Category.self, property: "items")
}
