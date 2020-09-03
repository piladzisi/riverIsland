//
//  Constants.swift
//  RiverIsland
//
//  Created by Anna Sibirtseva on 31/08/2020.
//  Copyright © 2020 Anna Sibirtseva. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    static let one: CGFloat = 1.0
    static let padding: CGFloat = 20.0
    
    enum Colors {
        static let black = UIColor.black
        static let white = UIColor.white
    }

    enum Strings {
        static let email = "Email address"
        static let password = "Password"
        static let signIn = "Sign in"
        static let register = "Register"
        static let dontHaveAccount = "Don't have and account?"
        static let haveAccount = "Already have an account?"
    }
    enum Button {
        static let skip = "Skip"
        static let forgotPassword = "Forgot Password?"
        static let signUp = "Sign up"
        static let signIn = "Sign in"
    }
}
