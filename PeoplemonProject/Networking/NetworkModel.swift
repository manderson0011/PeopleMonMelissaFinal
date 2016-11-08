//
//  NetworkModel.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/5/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//


import Foundation
import Alamofire
import Freddy


// Describes what you need to make a network request and read it

protocol NetworkModel: JSONDecodable {
    
    //create the object by reading Json
    init(json: JSON) throws
    //create an empty object
    init()
    
    //what is the HTTP Method (Get Post Put ect)
    
    func method() -> Alamofire.HTTPMethod
    // REST URL to the resource i.e. HTTP://SERVER.COME/POSTS/1
    func path() -> String
    //Convert the object to a dictionary for later conversion to JSON
    func toDictionary() -> [String: AnyObject]?
    
}


