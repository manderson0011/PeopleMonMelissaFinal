//
//  People.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/7/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//


import Foundation
import Alamofire
import Freddy
import AFDateHelper

// Just a test object to excercise the network stack
class People: NetworkModel {
    
    var login: String?
    var id: String?
    var userId: String?
    var userName : String?
    var password: String?
    var oldPassword: String?
    var email: String?
    var avatarBase64 : String?
    var latitude: Double?
    var longtitude: Double?
    var created: String?
    var conversationId: String?
    var recipientId: String?
    var recipientName: String?
    var lastMessage: String?
    var messageCount: Int?
    var senderId: String?
    var senderName: String?
    var recipientAvatar: String?
    var senderAvatar: String?
    var radius: Double?
    var grant_type: String?
    var expiration: Int?
    var caughtUserId: Int?
    var radiusInMeters: Double?
    var recipientAvatarBase64: String?
    var senderAvatarBase64: String?
    
    
    // Request Type
    enum RequestType {
        case nearby
        case checkin
        case catchPerson
        case caught
        case conversations
        case register
        case login
        
    }
    var requestType = RequestType.nearby
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        userId = try? json.getString(at: Constants.People.userId)
        userName = try? json.getString(at: Constants.People.userName)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        latitude = try? json.getDouble(at: Constants.People.latitude)
        longtitude = try? json.getDouble(at: Constants.People.longtitude)
        created = try? json.getString(at: Constants.People.created)
        radiusInMeters = try? json.getDouble(at: Constants.People.radiusInMeters)
        caughtUserId = try? json.getInt(at: Constants.People.caughtUserId)
        conversationId = try? json.getString(at: Constants.People.conversationId)
        recipientId = try? json.getString(at: Constants.People.recipientId)
        recipientName = try? json.getString(at: Constants.People.recipientName)
        lastMessage = try? json.getString(at: Constants.People.lastMessage)
        
        messageCount = try? json.getInt(at: Constants.People.messageCount)
        senderId = try? json.getString(at: Constants.People.senderId)
        senderName = try? json.getString(at: Constants.People.senderName)
        recipientAvatarBase64 = try? json.getString(at: Constants.People.recipientAvatarBase64)
        senderAvatarBase64 = try? json.getString(at: Constants.People.senderAvatarBase64)
        grant_type = try? json.getString(at: Constants.People.grantType)
        expiration = try? json.getInt(at: Constants.People.expiration)
    }
    
    
    
    
    init(avatarBase64: String, userName: String, userId: String, longtitude: Double, latitude: Double, created: String ) {
        self.avatarBase64 = avatarBase64
        self.userId = userId
        self.latitude = latitude
        self.longtitude = longtitude
        self.created = created
        requestType = .nearby
    }
    
    init(latitude: Double, longitude: Double) {
        self.longtitude = 0
        self.latitude = 0
        requestType = .checkin
    }
    init(caughtUserId: Int, radiusInMeters: Double) {
        self.caughtUserId = caughtUserId
        self.radiusInMeters = radiusInMeters
        requestType = .catchPerson
    }
    
    init(userId: String, avatarBase64: String, created: String,userName: String) {
        self.userId = userId
        self.userName = userName
        self.avatarBase64 = avatarBase64
        self.created = created
        requestType = .caught
    }
    
    
    init(conversationId: String, recipientId: String, recipientName: String, lastMessage: String, created: String, messageCount: Int, avatarBase64: String, senderId: String, senderName: String, recipientAvatarBase64: String, senderAvatarBase64: String) {
        
        self.avatarBase64 = avatarBase64
        self.conversationId = conversationId
        self.recipientId = recipientId
        self.lastMessage = lastMessage
        self.created = created
        self.messageCount = 0
        self.senderId = senderId
        self.senderName = senderName
        self.recipientAvatarBase64 = recipientAvatarBase64
        self.senderAvatarBase64 = senderAvatarBase64
        requestType = .conversations
        
    }
    
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .nearby:
            return .get
        case .checkin:
            return .post
        case .catchPerson:
            return .post
            //       case .conversation:
        //           return .get
        case .caught:
            return .get
        case .conversations:
            return .get
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .nearby:
            return "/v1/User/Nearby"
        case .checkin:
            return "/v1/User/CheckIn"
        case .catchPerson:
            return "/v1/User/Catch"
        case .caught:
            return "/v1/User/Caught"
        case .conversations:
            return "/v1/User/Conversations"
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
            
            //      case .conversation:
            //        return "/v1/User/Conversation"
            
            
        }
    }
        
        // Demo object isn't being posted to a server, so just return nil
        func toDictionary() -> [String: AnyObject]? {
            
            var params: [String: AnyObject] = [:]
            switch requestType {
                
            case .nearby:
                params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
                params[Constants.People.username] = userName as AnyObject?
                params[Constants.People.longtitude] = longtitude as AnyObject?
                params[Constants.People.latitude] = latitude as AnyObject?
                params[Constants.People.created] = created as AnyObject?
               
                return params
                
            case .caught:
                
                params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
                params[Constants.People.username] = userName as AnyObject?
                params[Constants.People.created] = created as AnyObject?
              
                return params
                
            case .catchPerson:
                params[Constants.People.caughtUserId] = caughtUserId as AnyObject?
                params[Constants.People.radiusInMeters] = radiusInMeters as AnyObject?
                
                return params
            
            case .checkin:
                params[Constants.People.longtitude] = longtitude as AnyObject?
                params[Constants.People.latitude] = latitude as AnyObject?
                
                return params
                
            case .conversations:
                params[Constants.People.conversationId] = avatarBase64 as AnyObject?
                params[Constants.People.recipientId] = userName as AnyObject?
                params[Constants.People.reipientName] = recipientName as AnyObject?
                params[Constants.People.lastMessage] = lastMessage as AnyObject?
                params[Constants.People.created] = created as AnyObject?
                params[Constants.People.messageCount] = messageCount as AnyObject?
                params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
                params[Constants.People.senderId] = senderId as AnyObject?
                params[Constants.People.senderName] = senderName as AnyObject?
                params[Constants.People.recipiantAvatar] = recipientName as AnyObject?
                params[Constants.People.senderAvatarBase64] = senderAvatarBase64 as AnyObject?
                
                return params
                
            default:
                return nil
            }
            
        }
    }

/*
 func dateString() -> String {
 if let date = Date {
 return date.toString(.custom(Constants.monthDayYear))
 }
 return ""
 }
 
 func dateDay() -> String {
 if let date = Date {
 if date.isThisWeek() {
 return date.weekdayToString()
 } else {
 return dateString()
 }
 }
 return ""
 }
 */
