
import Foundation
import CoreLocation
import MapKit

class Resturant: NSObject, MKAnnotation {
   
    var ratingImageUrl: String = ""
    var name: String = ""
    var phoneNumber: String = ""
    var imageUrl: String = ""
    var address: String = ""
    var categories: String = ""
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var latitude:  CLLocationDegrees = 0.0 //Double?
    var longitude: CLLocationDegrees = 0.0 //Double?
    
    
   // var ratingNumber : String = ""
   // var fullAdress : String = ""
    
    
   var location: CLLocationCoordinate2D  = CLLocationCoordinate2D()
    
    override init(){
        super.init()
    }
}