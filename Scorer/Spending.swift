//
//  Spending.swift
//  Scorer
//
//  Created by conilus on 2018/09/02.
//  Copyright © 2018年 conilus. All rights reserved.
//

import Foundation

struct Spending: Record {
    var id: Int = 0
    var score: Int
    var category_id: Int
    var started_at: Date
    
    init(score: Int, category_id: Int, started_at: Date) {
        self.score = score
        self.category_id = category_id
        self.started_at = started_at
    }
    
    static func create(score: Int, category_id: Int, started_at: Date) -> Spending {
      var record = Spending.init(score: score, category_id: category_id, started_at: started_at)
        record.save()
        return record
    }
}
