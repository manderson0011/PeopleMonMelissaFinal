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


    var id : String?
    var email : String?
    var hasRegistered: Bool?
    var loginProvider: String?
    var fullName: String?
    var avatarBase64: String?
    var lastCheckInLongitude: Double?
    var lastCheckInLatitude: Double?
    var lastCheckInDateTime: Date?
    
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    
    var password: String?
    var changePassword: String?
    var setPassword: String?
    
    var apiKey : String?
    var token : String?
    var expiration: String?
   
  
    
    
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
    //handles the type of request we re making
    // will determin our API endpoint eventually
    
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.User.token)
        expiration = try? json.getString(at: Constants.User.expiration)
        id = try? json.getString(at: Constants.User.id)
        email = try? json.getString(at: Constants.User.email)
        hasRegistered = try? json.getString(at: Constants.User.hasRegistered)
        loginProvider  = try? json.getString(at: Constants.User.loginProvider)
        fullName = try? json.getString(at: Constants.User.fullName)
        avatarBase64 = try? json.getString(at: Constants.User.avatarBase64)
        lastCheckInDateTime = try? json.getString(at: Constants.UserlastCheckInDateTime)
        lastCheckInLatitude = try? json.getString(at: Constants.User.lastCheckInLatitude)
        lastCheckInLongitude = try? json.getString(at: Constants.User.lastCheckInLongitude)
        
    }
    init(fullName: String, email: String, hasRegistered: String, loginProvider: String, avatarBase64: String, lastCheckInLongtitude: Double, lastCheckInLatitude: Double, lastCheckInDateTime: Date) {
        self.fullName = fullName
        self.email = email
        self.loginProvider = loginProvider
        self.avatarBase64 = avatarBase64
        self.lastCheckInLongitude = lastCheckInLongtitude
        self.lastCheckInLatitude = lastCheckInLatitude
        self.lastCheckInDateTime = lastCheckInDateTime
        requestType = .postUserInfo
    }
    init(email: String, password: String, changePassword: String) {
        self.email = email
        self.password = password
        requestType = .login
    }
    
    init(email: String, fullName: String, AvatarBase64: String, password: String, apiKey: String) {
        self.fullName = fullName
        self.AvatarBase64 = AvatarBase64
        self.password = password
        self.email = email
        self.apiKey = apiKey
        requestType = .register
    }
    init(setPassword: String, oldPassword: String, confirmPassword: String, changePassword: String) {
        self.setPassword = setPassword
        self.oldPassword = oldPassword
        self.confirmPassword = confirmPassword
        self.changePassword = changePassword
        requestType = .changePassword
    }
    init(newPassword: String) {
        self.newPassword = newPassword
        requestType = .setPassword
    }
    
    init(fullName: String, avatarBase64: String) {
        
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        requestType = .getUserInfo
    }

//Determins the HTTP  method we will use in our calls Can use conditionals to determine this based on the endpoint we are calling or what we decide we would lke to do 
    
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .getUserInfo:
            return .get
        case.login:
            return .post
        case.changePassword:
            return .post
        case.register:
            return .post
        case .setPassword:
            return .post
        default:
            return .post
        }
    }
    
    //Determins the path we will append to the Api base url
    //we switch this endpoint based on what type of request we would like to make
    
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
    
    
    //
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        switch requestType {
        case .getUserInfo
                 
        case .register:
        params[Constants.User.fullname] = fullName as AnyObject?
        params[Constants.User.email] = email as AnyObject?
        params[Constants.User.password] = password as AnyObject?
        params[Constants.User.avatarBase64] = avatarBase64 as AnyObject?
        params[Constants.User.apiKey] = apiKey as AnyObject?
        
        case .login:
        params[Constants.User.email] = changePassword as AnyObject?
        params[Constants.User.password] = username as AnyObject?
        params[Constants.User.grantType] = grantType as AnyObject?
        default:
            break
        }
        
        return params
    }



}
