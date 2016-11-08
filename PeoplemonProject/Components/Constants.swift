//
//  Constants.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/5/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//
import Foundation
import UIKit

struct Constants {
    // Step 16: Add monthDayYear
    static let monthDayYear = "MM/dd/yyyy"
    
    // Step 7: Add keychain strings
    public static let keychainIdentifier = "ProjectPeoplemonKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    static let apiKey = "iOSandroid301november2016"
    static let radius = 100.0
    
    
    
    // JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
    
    
    // Step 10: User Constants
    struct People {
        
        static let id = "id"
        static let Email = "email"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        static let hasRegistered = "hasRegistered"
        static let loginProvider = "loginProvider"
        static let avatarBase64 = "avatarBase64"
        static let lastCheckInLongitude = "0"
        static let lastCheckInLatitude = "0"
        static let lastCheckInDateTime = "0"
        
        
    }
    
    // Step 11: User Constants
    struct User{
        static let userID = "userId"
        static let avatarBase64 = "avatarBase64"
        static let longitude = "0"
        static let latitude = "0"
        static let created = "2016-11-03T20:44:12.608Z"
        static let conversationId = "conversationId"
        static let recipientId = "recipientId"
        static let reipientName = "recipientName"
        static let lastMessage = "lastMessage"
        static let messageCount = "messageCount"
        static let senderId = "senderId"
        static let senderName = "senderName"
        static let recipiantAvatar = "recipiantAvatar"
        static let senderAvatar = "senderAvatar"
        static let userId = "userId"
        static let email = "email"
        static let username = "username"
        static let fullname = "fullname"
        static let password = "password"
        static let apiKey = "iOSandroid301november2016"
        static let token = "token"
        
        
    }
}

// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    static let PositiveColor = UIColor.rgba(red: 15, green: 181, blue: 46)
    static let NegativeColor = UIColor.rgba(red: 219, green: 31, blue: 31)
    static let BlueColor = UIColor.rgba(red: 12, green: 35, blue: 64)
    static let GoldColor = UIColor.rgba(red: 201, green: 151, blue: 0)
    static let calendarCellColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let calendarTodayColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.3)
    static let calendarBorderColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.8)
}





