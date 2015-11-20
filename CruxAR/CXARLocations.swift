//
//  ARLocations.swift
//  CruxAR
//
//  Created by Andrew on 2015-10-24.
//  Copyright © 2015 Wikitude. All rights reserved.
//

import UIKit
import MapKit
import AFNetworking
import JSONHelper


struct Location: Deserializable  {
    var id : Int?
    var name : String?
    var locationDescription : String?
    var address : String?
    var latitude : Double?
    var longitude : Double?
    var createdAt : String?
    var updatedAt : String?
    
    init(data: [String: AnyObject]) {
        id <-- data["id"]!
        name <-- data["name"]!
        locationDescription <-- data["description"]!
        address <-- data["address"]!
        latitude <-- data["latitude"]!
        longitude <-- data["longitude"]!
        createdAt <-- data["created_at"]!
        updatedAt <-- data["updated_at"]!
    }
    
}

typealias CompletionHandler = (success:Bool) -> Void

var locationArray: [Location]? = []



func loadLocations(completionHandler: CompletionHandler)  {
    
    var locations: [Location]?
    
    AFHTTPRequestOperationManager().GET(
        "https://sleepy-headland-7668.herokuapp.com/api/v1/locations?access_token=d144cf29aba4052f097463b92e67dff8",
        parameters: nil,
        success: { operation, data in
            locations <-- data["locations"]!
            
            if let locations = locations {
                locationArray = locations
                
                let flag = true // true if download succeed,false otherwise
                
                completionHandler(success: flag)
            } else {
                let flag = false // true if download succeed,false otherwise
                
                completionHandler(success: flag)
            }
        },
        failure: { operation, error in
            // Handle error.
    })
}
