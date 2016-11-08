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
    var userId: String?
    var userName : String?
    var password: String?
    var email: String?
    var avatarBase64 : String?
    var latitude: Double?
    var longtitude: Double?
    var created: String?
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
        self.created =
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
        self.longtitude = longtitude
        self.latitude = latitude
        requestType = .checkin
    }
    init(conversationId: Int, recipientId: String, recipientName: String, lastMessage: Date, created: Date, messageCount: Int, avatarBase64: String, senderId: String, senderName: String, recipientAvatarBase64: String, senderAvatarBase64: String) {
        
        self.avatarBase64 = avatarBase64
        self.conversationId = conversationId
        self.recipientId = recipientId
        self.lastMessage = lastMessage
        self.created = created
        self.messageCount = messageCount
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
    
    
    func dateString() -> String {
        if let date = date {
            return date.toString(.custom(Constants.monthDayYear))
        }
        return ""
    }
    
    func dateDay() -> String {
        if let date = date {
            if date.isThisWeek() {
                return date.weekdayToString()
            } else {
                return dateString()
            }
        }
        return ""
    }
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        switch requestType {
        
        case .checkin:
        params[Constants.People.id] = id as AnyObject?
        params[Constants.People.email] = email as AnyObject?
        params[Constants.People.oldPassword] = oldPassword as AnyObject?
        params[Constants.People.newPassword] = newPassword as AnyObject?
        params[Constants.People.confirmPassword] = confirmPassword as AnyObject?
        params[Constants.People.hasRegistered] = hasRegistered as AnyObject?
        params[Constants.People.longinProvider] = loginProvider as AnyObject?
        params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
        params[Constants.People.lastCheckInLatitude] = lastCheckInLatitude as AnyObject?
        params[Constants.People.lastCheckInLongitude] = lastCheckInLongitude as AnyObject?
        params[Constants.People.lastCheckInDateTime] = lastCheckInDateTime as AnyObject?
        params[Constants.People.date] = date?.toString(.iso8601(nil)) as AnyObject?
        
        
        switch requestType {
        case .register:
            params[Constants.People.email] = email as AnyObject?
        default:
            break
        }
        
        return params
    }
    
}
