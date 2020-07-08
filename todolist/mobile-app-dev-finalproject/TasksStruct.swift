//
//  TasksStruct.swift
//  mobile-app-dev-finalproject
//
//  Created by Abbe♡ on 2020/7/1.
//  Copyright © 2020 NTNU. All rights reserved.
//

import Foundation

struct Tasks: Codable {
    
    var items = [Item]()
    
    struct Item : Codable {
        
        var title: String
        var body: String
        
        init(title: String, body: String) {
            self.title = title
            self.body = body
        }
    }
    
    mutating func addItem(title: String, body: String) {
        items.append(Item(title: title, body: body))
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Tasks.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init() {
        
    }
    
}
