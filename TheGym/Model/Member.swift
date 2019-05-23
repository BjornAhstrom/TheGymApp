//
//  Member.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import Foundation

class Member {
    var userName: String?
    var firstName: String?
    var lastName: String?
    var adress: String?
    var phoneNumber: String?
    var mail: String?
    var id: String?
    
    init(json: [String : Any]) {
        userName = json["userName"] as? String ?? ""
        firstName = json["firstName"] as? String ?? ""
        lastName = json["lastName"] as? String ?? ""
        adress = json["adress"] as? String ?? ""
        phoneNumber = json["phoneNumber"] as? String ?? ""
        mail = json["mail"] as? String ?? ""
        id = json["id"] as? String ?? ""
    }
}
