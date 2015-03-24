//
//  DribbbleAPI.swift
//  Pinkapple
//
//  Created by yuye wang on 3/23/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import Foundation

class DribbbleAPI {
    
    let accessToken = "9572b38ed3d933d8026f6ee2fb6cdbd97acd14ff7844847176c197535e9ef14a"
    
    func loadShots(completion: (([Shot]) -> Void)!){
        
        var urlString = "https://api.dribbble.com/v1/shots?access_token=" + accessToken
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(shotsUrl!){
            (data, response, error) -> Void in
            
            if error != nil{
                println(error.localizedDescription)
            }else{
                // if succeed, handle information
                var error :NSError?
                
                var shotsData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error:  &error) as NSArray
                
                var shots = [Shot]()
                
                for shot in shotsData{
                    let shot = Shot(data: shot as NSDictionary)
                    shots.append(shot)
                }
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()){
                        completion(shots)
                    }
                }
                
            }
            
        }
        task.resume()
    }
}