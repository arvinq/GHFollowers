//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/21/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

// Associated Value are for each cases can have different type,
// raw value is for the whole enum where all cases conform to one type
// conforming to error for Result type
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your network connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
