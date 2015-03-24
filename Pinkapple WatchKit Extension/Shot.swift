//
//  Shot.swift
//  Pinkapple
//
//  Created by yuye wang on 3/23/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import Foundation

class Shot{
    
    var id : Int!
    var title : String!
    var date : String!
    var description : String!
    var commentCount : Int!
    var likesCount : Int!
    var viewsCount : Int!
    var commentUrl : String!
    var imageUrl : String!
    
    var imageData : NSData?
    
    var user : User!
    
    
    init(data : NSDictionary){
        // put data from the dictionary into our variables
        self.id = data["id"] as Int
        self.commentCount = data["comments_count"] as Int
        self.likesCount = data["likes_count"] as Int
        self.viewsCount = data["views_count"] as Int
        
        self.commentUrl = Utils.getStringFromJSON(data, key: "comments_url")
        self.title = Utils.getStringFromJSON(data, key: "title")
        
        let dateInfo = Utils.getStringFromJSON(data, key: "created_at")
        self.date = dateInfo
        
        let desc = Utils.getStringFromJSON(data, key: "description")
        self.description = desc
        
        let images = data["images"] as NSDictionary
        self.imageUrl = Utils.getStringFromJSON(images, key: "normal")
        
        if let userData = data["user"] as? NSDictionary {
            self.user = User(data: userData)
        }
        
    }
    
    
    
}
