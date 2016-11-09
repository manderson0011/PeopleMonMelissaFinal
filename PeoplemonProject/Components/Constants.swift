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
    static let apiKey = "iOS301november2016"
    static let radius = 100.0
    
    
    
    // JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    
    }
    
    
    // Step 10: User Constants
    struct People {
        
        static let id = "Id"
        static let email = "Email"
        static let userId = "UserId"
        static let username = "userName"
        static let fullName = "FullName"
 
        static let created = "2016-11-03T20:44:12.608Z"
        static let conversationId = "conversationId"
        static let recipientId = "recipientId"
        static let reipientName = "recipientName"
        static let lastMessage = "lastMessage"
        static let message = "message"
        static let messageCount = "messageCount"
        static let senderId = "senderId"
        static let senderName = "senderName"
        static let recipiantAvatar = "recipiantAvatar"
        static let senderAvatar = "senderAvatar"
        
        static let avatarBase64 = "AvatarBase64"
        static let oldPassword = "OldPassword"
        static let newPassword = "NewPassword"
        static let confirmPassword = "ConfirmPassword"
        static let hasRegistered = "HasRegistered"
        static let loginProvider = "LoginProvider"
        
        static let AvatarBase64 = "AvatarBase64"
        static let senderAvatarBase64 = "enderAvatarBase64"
        static let recipientAvatarBase64 = "recipientAvatarBase64"
        static let recipientName = "recipientName"
        
        static let LastCheckInLongitude = "0"
        static let LastCheckInLatitude = "0"
        static let LastCheckInDateTime = "0"
        
        
        static let apiKey = "ApiKey"
        static let token = "access_token"
        static let grantType = "password"
        static let expiration = ".expires"

        static let userID = "UserId"
        static let userName = "username"
        static let password = "password"
        
        static let caughtUserId = "CaughtUserId"
        static let radiusInMeters = "RadiusInMeters"
        
        static let changePassword = "changepassword"
        static let setPassword = "setPassword"
        static let longitude = "Longitude"
        static let latitude = "Latitude"
        
     
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





