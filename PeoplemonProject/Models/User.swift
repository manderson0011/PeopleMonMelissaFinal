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
    var userName: String?
    var email : String?
    var hasRegistered: Bool?
    var loginProvider: String?
    var fullName: String?
    var avatarBase64: String?
    var lastCheckInLongitude: Double?
    var lastCheckInLatitude: Double?
    var lastCheckInDateTime: String?
    
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    
    var password: String?
    var changePassword: String?
    var setPassword: String?
    
    var apiKey : String?
    var token : String?
    var expiration: String?
    var grantType: String?
    
    
    
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
    required init() {
            requestType = .getUserInfo
    }
    
    // create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.People.token)
        expiration = try? json.getString(at: Constants.People.expiration)
        id = try? json.getString(at: Constants.People.userID)
        email = try? json.getString(at: Constants.People.email)
        hasRegistered = try? json.getBool(at: Constants.People.hasRegistered)
        loginProvider  = try? json.getString(at: Constants.People.loginProvider)
        fullName = try? json.getString(at: Constants.People.fullName)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        lastCheckInDateTime = try? json.getString(at: Constants.People.LastCheckInDateTime)
        lastCheckInLatitude = try? json.getDouble(at: Constants.People.LastCheckInLatitude)
        lastCheckInLongitude = try? json.getDouble(at: Constants.People.LastCheckInLongitude)
        oldPassword = try? json.getString(at: Constants.People.oldPassword)
        newPassword = try? json.getString(at: Constants.People.newPassword)
        confirmPassword = try? json.getString(at: Constants.People.confirmPassword)
        apiKey = try? json.getString(at: Constants.People.apiKey)
        password = try? json.getString(at: Constants.People.password)
        token = try? json.getString(at: Constants.People.token)
        expiration = try? json.getString(at: Constants.People.expiration)
        grantType = try? json.getString(at: Constants.People.grantType)
    }
    init(fullName: String, email: String, hasRegistered: String, loginProvider: String, avatarBase64: String, lastCheckInLongitude: Double, lastCheckInLatitude: Double, lastCheckInDateTime: String) {
        self.fullName = fullName
        self.email = email
        self.loginProvider = loginProvider
        self.avatarBase64 = avatarBase64
        self.lastCheckInLongitude = lastCheckInLongitude
        self.lastCheckInLatitude = lastCheckInLatitude
        self.lastCheckInDateTime = lastCheckInDateTime
        requestType = .postUserInfo
    }
    init(email: String, password: String, grantType: String) {
        self.grantType = grantType
        self.userName = email
        self.password = password
        requestType = .login
    }
    
    
    init(Email: String, fullName: String, AvatarBase64: String, Password: String) {
        self.email = Email
        self.fullName = fullName
        self.avatarBase64 = AvatarBase64
        self.apiKey = Constants.apiKey
        self.password = Password
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
            return "/api/Account/UserInfo"
        case .postUserInfo:
            return "/api/Account/UserId"
        }
    }
    
    
    //
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        switch requestType {
            
        case .getUserInfo:
            params[Constants.People.id] = id as AnyObject?
            params[Constants.People.email] = email as AnyObject?
            params[Constants.People.hasRegistered] = hasRegistered as AnyObject?
            params[Constants.People.loginProvider] = loginProvider as AnyObject?
            params[Constants.People.LastCheckInDateTime] = lastCheckInDateTime as AnyObject?
            params[Constants.People.LastCheckInLongitude] = lastCheckInLongitude as AnyObject?
            params[Constants.People.LastCheckInLatitude] = lastCheckInLatitude as AnyObject?
            
        case .postUserInfo:
            params[Constants.People.fullName] = fullName as AnyObject?
            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
            
            
        case .login:
            params["grant_type"] = grantType as AnyObject?
            params[Constants.People.username] = userName as AnyObject?
            params[Constants.People.password] = password as AnyObject?
            
        case .changePassword:
            params[Constants.People.oldPassword] = oldPassword as AnyObject?
            params[Constants.People.newPassword] = newPassword as AnyObject?
            params[Constants.People.confirmPassword] = confirmPassword as AnyObject?
            
        case .setPassword:
            params[Constants.People.oldPassword] = oldPassword as AnyObject?
            
        case .register:
            params[Constants.People.email] = email as AnyObject?
            params[Constants.People.fullName] = fullName as AnyObject?
            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.People.apiKey] = apiKey as AnyObject?
            params[Constants.People.password] = password as AnyObject?
            
            
        default:
            break
        }
        
        return params
    }
    
    
    
}
