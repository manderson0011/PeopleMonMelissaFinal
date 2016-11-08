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

// Just a test object to excercise the network stack
class People : NetworkModel {
    
    
    var username : String?
    var avatarBase64 : String?
    var latitude: Double?
    var longtitude: Double?
    var created: Int?
    var conversationID: String?
    var recipientId: String?
    var recipientName: String?
    var lastMessage: String?
    var messageCount: String?
    var senderId: String?
    var senderName: String?
    var recipientAvatar: String?
    var senderAvatar: String?
    var radius: String?
    var grant_type: String?
    var expiration: Int?
    
    
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
        grant_type = try? json.getString(at: Constants.User.token)
        
    }
    
    init(username: String, password: String) {
        self.login = login
        self.username = username
        self.password = password
        requestType = .login
    }
    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
        requestType = .register
    }
    
    init(UserId: Int) {
        self.userId = userId
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        return .post
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        params[Constants.People.UserID] = userId as AnyObject?
        params[Constants.People.username] = username as AnyObject?
        params[Constants.People.AvatarBase64] = avatarBase64 as AnyObject?
        params[Constants.People.latitude] = latitude as AnyObject?
        params[Constants.People.Longitude] = longitude as AnyObject?
        params[Constants.People.created] = created as AnyObject?
        
        
        
        switch requestType {
        case .register:
            params[Constants.UserInfo.email] = email as AnyObject?
        default:
            break
        }
        
        return params
    }
    
}
