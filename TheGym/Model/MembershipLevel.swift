//
//  MembershipLevel.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import Foundation

class MembershipLevel {
    var gold: Bool?
    var silver: Bool?
    var bronze: Bool?
    
    init(json: [String : Any]) {
        gold = json["gold"] as? Bool ?? false
        silver = json["silver"] as? Bool ?? false
        bronze = json["bronze"] as? Bool ?? false
    }
    
}
