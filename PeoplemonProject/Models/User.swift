//
//  User.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/7/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//


import Foundation
import Alamofire
import Freddy

// Just a test object to excercise the network stack
class User : NetworkModel {
    
    var userId : String?
    var username: String?
    var email : String?
    var password: String?
    var changePassword: String?
    var setPassword: String?
    var confirmPassword: String?
    var hasRegistered: Bool?
    var loginProvider: String?
    var fullName: String?
    var avatarBase64: String?
    var lastCheckInLongitude: Double?
    var lastCheckInLatitude: Double?
    var lastCheckInDateTime: Date?
    var apiKey : String?
    var token : String?
    
    
    
    
    // Request Type
    enum RequestType {
        case login
        case register
        case changePassword
        case setPassword
        case getUserInfo
        case postUserInfo
        
    }
    var requestType = RequestType.login
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.User.token)
    }
    
    init(userId: String, changePassword: String, setPassword: String) {
        self.userId = userId
        self.setPassword = setPassword
        self.changePassword = changePassword
        requestType = .login
    }
    
    init(userId: String, password: String, email: String) {
        self.userId = userId
        self.password = password
        self.email = email
        requestType = .register
    }
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .getUserInfo:
            return .get
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
        case .setPassword:
            return "/api/Account/SetPassword"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .getUserInfo:
            return "/api/Account/UserId"
        case .postUserInfo:
            return "/api/Account/UserId"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        params[Constants.User.username] = username as AnyObject?
        params[Constants.User.password] = password as AnyObject?
        
        
        switch requestType {
        case .register:
            params[Constants.User.email] = email as AnyObject?
        default:
            break
        }
        
        return params
    }
    
}
