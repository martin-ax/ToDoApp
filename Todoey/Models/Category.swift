//
//  Category.swift
//  Todoey
//
//  Created by Martin Arellano on 7/16/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
