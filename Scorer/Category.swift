//
//  Category.swift
//  Scorer
//
//  Created by conilus on 2018/09/02.
//  Copyright © 2018年 conilus. All rights reserved.
//

import UIKit

struct Category: Record {
    var id: Int = 0
    var name: String
    var color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }

    static func create(name: String, color: UIColor) -> Category {
        var record = Category.init(name: name, color: color)
        record.save()
        return record
    }
}
