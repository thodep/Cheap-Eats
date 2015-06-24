

// Create usercoordinates CLLLocation 

import CoreLocation

class YelpClient: BDBOAuth1RequestOperationManager {

    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        var credential = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)

        self.requestSerializer.saveAccessToken(credential)
    }
    
    func searchWithTerm(term: String,
                    parameters: Dictionary<String, String>? = nil,
                    offset:Int,
                    limit: Int = 20,
                    success: ([Resturant]?) -> Void,
        failure: (AFHTTPRequestOperation!, error:NSError!) -> Void) -> AFHTTPRequestOperation! {
        
                        var params: NSMutableDictionary = [
                            "term": term,
                            "offset": offset,
                            "limit": limit
                        ]
                        for (key, value) in parameters! {
                            params.setValue(value, forKey: key)
                        }
                        return self.GET("http://api.yelp.com/v2/search", parameters: params, success: { (operation:AFHTTPRequestOperation!, object:AnyObject!) -> Void in
                            if let json = object as? Dictionary<String, AnyObject>,
                                let businesses = json["businesses"] as? Array<Dictionary<String, AnyObject>>{
                                    
                                    var resultArray: Array<Resturant> = Array()
                                    for dict in businesses {
                                        let resturant = Resturant()
                                       
                                        if let ratingImageUrl = dict["rating_img_url"] as? String{
                                            resturant.ratingImageUrl = ratingImageUrl
                                        }
                                        
                                        if let imageUrl = dict["image_url"] as? String{
                                            resturant.imageUrl = imageUrl
                                        }
                                        
                                        if let resName = dict["name"] as? String{
                                            resturant.name = resName
                                        }
                                        
                                        if let location = dict["location"] as? NSDictionary {
                                            if let address = location["address"] as? Array<String> {
                                                if let neighborhoods = location["neighborhoods"] as? Array<String> {
                                                    resturant.address = ", ".join(address + [neighborhoods[0]])
                                                }
                                            }
                                        }
                                     
                                        if let category = dict["categories"] as? Array<Array<String>> {
                                            resturant.categories = ", ".join(category.map({ $0[0] }))
                                        }

                                        if let resPhone = dict["display_phone"] as? String {
                                            resturant.phoneNumber = resPhone
                                            
                                        }
                                        
                                   
                                        // to get store latitute/ longtitude
                                        if let location = dict["location"] as? Dictionary<String, AnyObject>,
                                         let coordinate = location["coordinate"] as? Dictionary<String, Double> {
                                      
                                            let lat = coordinate["latitude"]
                                            let long = coordinate["longitude"]
                                            resturant.coordinate = CLLocationCoordinate2DMake(lat!, long!)
                                            
                                            }
                                        
                                     
                                        
                                        resultArray.append(resturant)
                                    }
                                    success(resultArray)
                                }
                            }, failure: failure)
    }
}