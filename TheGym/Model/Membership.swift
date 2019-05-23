//
//  Membership.swift
//  TheGym
//
//  Created by Björn Åhström on 2019-05-22.
//  Copyright © 2019 Björn Åhström. All rights reserved.
//

import Foundation

class Membership {
    var member: Member
    var membershipLevel: MembershipLevel
    
    init(member: Member, membershipLevel: MembershipLevel) {
        self.member = member
        self.membershipLevel = membershipLevel
    }
}
