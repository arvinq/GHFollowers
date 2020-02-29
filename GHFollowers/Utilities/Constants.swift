//
//  Constants.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/29/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

enum SFSymbols {
    static let location  = "mappin.and.ellipse"
    static let repos     = "folder"
    static let gists     = "text.alignleft"
    static let follower  = "heart"
    static let following = "person.2"
}

enum ItemInfoType: String {
    case repos     = "Public Repose"
    case gists     = "Public Gists"
    case follower  = "Followers"
    case following = "Following"
}
