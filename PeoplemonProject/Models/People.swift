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
class People : NetworkModel {
    
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
    var created: Date
    var conversationId: Int?
    var recipientId: String?
    var recipientName: String?
    var lastMessage: Date?
    var messageCount: Int?
    var senderId: String?
    var senderName: String?
    var recipientAvatar: String?
    var senderAvatar: String?
    var radius: String?
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
        case conversation
        case register
        
    }
    var requestType = RequestType.nearby
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        grant_type = try? json.getString(at: Constants.People.token)
    }
    
    init(avatarBase64: String, userName: String, userId: String, longtitude: Double, latitude: Double, created: Date ) {
        self.avatarBase64 = avatarBase64
        self.userId = userId
        self.latitude = latitude
        self.longtitude = longtitude
        self.created = created
        requestType = .nearby
    }
    
    init(caughtUserId: Int, radiusInMeters: Double) {
        self.caughtUserId = caughtUserId
        self.radiusInMeters = radiusInMeters
        requestType = .catchPerson
    }
    
    init(userId: String, avatarBase64: String, created: Date,userName: String) {
        self.userId = userId
        self.userName = userName
        self.avatarBase64 = avatarBase64
        self.created = created
        requestType = .caught
    }
    
    init(latitude: Double, longitude: Double) {
        self.longtitude = 0
        self.latitude = 0
        requestType = .checkin
    }
    init(conversationId: Int, recipientId: String, recipientName: String, lastMessage: Date, created: Date, messageCount: Int, avatarBase64: String, senderId: String, senderName: String, recipientAvatarBase64: String, senderAvatarBase64: String) {
        
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
        case .caught:
            return .get
        case .conversations:
            return .get
        case .conversation:
            return .get
        case .checkin:
            return .post
        case .catchPerson:
            return .post
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .nearby:
            return "/v1/User/Nearby"
        case .register:
            return "/api/Account/Register"
        case .caught:
            return "/v1/User/Caught"
        case .conversation:
            return "/v1/User/Conversation"
        case .conversations:
            return "/v1/User/Conversations"
        case .catchPerson:
            return "/v1/User/Catch"        }
    }
    
    
       // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        switch requestType {
        
        case .nearby:
            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.People.username] = userName as AnyObject?
            params[Constants.People.Longtitude] = longtitude as AnyObject?
            params[Constants.People.Latitude] = latitude as AnyObject?
            params[Constants.People.created] = created as AnyObject?

        case .caught:

            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.People.username] = userName as AnyObject?
            params[Constants.People.created] = created as AnyObject?

        case .catchPerson:
            params[Constants.People.caughtUserId] = caughtUserId as AnyObject?
            params[Constants.People.radiusInMeters] = radiusInMeters as AnyObject?
        
        case .checkin:
            params[Constants.People.Longtitude] = longtitude as AnyObject?
            params[Constants.People.Latitude] = latitude as AnyObject?
            
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
    
    
        
        

            
        default:
            break
        }
        
        return params
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
