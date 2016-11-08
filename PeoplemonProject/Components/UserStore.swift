//
//  UserStore.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/5/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import Foundation




class UserStore {
    //singleton
    static let shared = UserStore()
    private init() {}
    
    //give me a user then i will log them in and tell you when they are logged in
    
    
    func login(_ loginUser: User, completion: @escaping (_ success:Bool, _ error: String?) -> Void) {
        
        //call web server to login
        WebServices.shared.authUser(loginUser) {(user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            }else{
                completion(false, error)
            }
        }
    }
    func register(_ registerUser: User, completion:@escaping
        (_ success: Bool, _ error: String?) -> ()) {
        
        WebServices.shared.authUser(registerUser) {(user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            }else{
                completion(false, error)
                
            }
        }
    }
    
    func logout(_ completion:()->()) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }
}

