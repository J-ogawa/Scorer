//
//  Record.swift
//  Scorer
//
//  Created by conilus on 2018/09/06.
//  Copyright © 2018年 conilus. All rights reserved.
//

import Foundation

protocol Record {
    var id: Int { set get }

    static func all() -> [Self]
    static func find(id: Int) -> Self?
}

extension Record {
    static func archive_key() -> String {
        return "\(type(of: self))_data"
    }
    
    static func all() -> [Self] {
       return UserDefaults.standard.unarchive(key: archive_key()) as? [Self] ?? []
    }
    
    static func find(id: Int) -> Self? {
        return all().filter { $0.id == id }.first
    }
    
    func incrementedId() -> Int {
        return (Self.all().map { $0.id }.max() ?? 0) + 1
    }
    
    mutating func save() {
        if self.id != 0 { return }
        
        id = incrementedId()
        
//        print("\(Self.all() + [self])")
//        UserDefaults.standard.archive(value: (Self.all() + [self]), forKey: Self.archive_key())
    }
}
