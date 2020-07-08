//
//  ContactJSON.swift
//  mobile-app-dev-hw3
//
//  Created by Abbe♡ on 2020/6/9.
//  Copyright © 2020 NTNU. All rights reserved.
//

// model

import Foundation

struct Contact: Codable
{
    var contacts = [PersonalInfo]()
    
    struct PersonalInfo: Codable {
        let name: String
        init(name: String) {
            self.name = name
        }
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Contact.self, from: json) {
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
