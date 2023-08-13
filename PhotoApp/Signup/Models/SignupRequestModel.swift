//
//  SignupRequestModel.swift
//  PhotoApp
//
//  Created by Brian Ortiz on 2023-08-07.
//  Copyright © 2023 Sergey Kargopolov. All rights reserved.
//

import Foundation

struct SignupRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
