//
//  Constants.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 30/12/23.
//

import Foundation

struct Constants
{

    static let appName = "iMoodi"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "FeedsViewCell"
    static let messageSellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToDashBoard"
    static let isUserLoggedInKey = "isUserLoggedInKey"
    static let userEmail = "user_email"
    
    
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
