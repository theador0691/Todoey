//
//  Category.swift
//  Todoey
//
//  Created by Andrew Taylor on 10/04/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
