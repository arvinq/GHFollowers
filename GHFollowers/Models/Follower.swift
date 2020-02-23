//
//  Follower.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/17/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    // func hash(into hasher: inout Hasher) {
    //     hasher.combine(login)
    // }
}
