
import Foundation
import CoreLocation
import MapKit

class Resturant: NSObject {
   
    var ratingImageUrl: String = ""
    var name: String = ""
    var phoneNumber: String = ""
    var imageUrl: String = ""
    var address: String = ""
    var categories: String = ""
    
   // var ratingNumber : String = ""
    //var fullAdress : String = ""
    
    
    var location: CLLocationCoordinate2D  = CLLocationCoordinate2D()
    
    override init(){
        super.init()
    }
}