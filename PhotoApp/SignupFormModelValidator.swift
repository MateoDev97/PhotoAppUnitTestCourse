//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Sergey Kargopolov on 2020-02-25.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import Foundation

class SignupFormModelValidator {
    
    func isFirstNameValid(firstName: String) -> Bool {
        firstName.count > SignupConstants.firstNameMinLength && firstName.count <= SignupConstants.firstNameMaxLength
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        lastName.count > SignupConstants.lastNameMinLength && lastName.count <= SignupConstants.lastNameMaxLength
    }
    
    func isValidEmailFormat(email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
}
