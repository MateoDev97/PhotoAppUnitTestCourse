//
//  SignupError.swift
//  PhotoApp
//
//  Created by Brian Ortiz on 2023-08-07.
//  Copyright © 2023 Sergey Kargopolov. All rights reserved.
//

import Foundation


enum SignupError: Error, Equatable {
    case responseModelParsingError
    case invalidUrl
    case failedRequest(description: String)
}
