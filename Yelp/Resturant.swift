//
//  Resturant.swift
//  Yelp
//
//  Created by tho dang on 2015-06-18.
//  Copyright (c) 2015 Jerry Su. All rights reserved.
//

import Foundation
import CoreLocation

class Resturant: NSObject {
   
    var ratingImageUrl: String = ""
    var name: String = ""
    var phoneNumber: String = ""
    var imageUrl: String = ""
    var address: String = ""
    var categories: String = ""
    
    var location: CLLocationCoordinate2D  = CLLocationCoordinate2D()
    
    override init(){
        super.init()
    }
}