//
//  Extensions.swift
//  Scorer
//
//  Created by conilus on 2018/09/02.
//  Copyright © 2018年 conilus. All rights reserved.
//

import Foundation

extension UserDefaults {
    func unarchive(key: String) -> Any? {
        var value: Any? = nil
        if let data = data(forKey: key) {
            value = NSKeyedUnarchiver.unarchiveObject(with: data)
        }
        return value
    }
    
    func archive(value: Any, forKey key: String) {
        set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    }
}
