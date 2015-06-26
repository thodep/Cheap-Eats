

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var restaurantRating: UILabel!
    
    @IBOutlet weak var restaurantCategories: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var restaurantAddress: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
        
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var resDistance: UILabel!
    
    
    var resturant: Resturant?
    var destination: MKMapItem?
    var region:MKCoordinateRegion?
    var userLocation:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set Direction Button shape and color
        directionButton.layer.cornerRadius = 5
        directionButton.layer.masksToBounds = true
        directionButton.layer.borderColor = UIColor.grayColor().CGColor
        directionButton.layer.borderWidth = 1.0
        // Set callButton shape and Color
        callButton.layer.cornerRadius = 5
        callButton.layer.masksToBounds = true
        callButton.layer.borderColor = UIColor.grayColor().CGColor
        callButton.layer.borderWidth = 1
        
        restaurantNameLabel.text = resturant?.name
        restaurantAddress.text = resturant?.address
        
        restaurantAddress.layer.cornerRadius = 5
        restaurantAddress.layer.masksToBounds = true
        restaurantAddress.layer.borderColor = UIColor.grayColor().CGColor
        restaurantAddress.layer.borderWidth = 1.0
        
        restaurantCategories.text = resturant?.categories
        if phoneNumber !== nil{
            phoneNumber.text = resturant?.phoneNumber}
        
        if let number = resturant?.imageUrl {
            self.restaurantImage.sd_setImageWithURL(NSURL(string: number))
            restaurantImage.layer.cornerRadius = 5
            restaurantImage.layer.masksToBounds = true
            restaurantImage.layer.borderColor = UIColor.grayColor().CGColor
            restaurantImage.layer.borderWidth = 1.0
        }
        
        if let rateImage = resturant?.ratingImageUrl {
            self.ratingImage.sd_setImageWithURL(NSURL(string: rateImage))
        }
    }
    
    func myImageObject(url:NSString) -> UIImage {
        let url = NSURL(string: url as String)
        let data = NSData(contentsOfURL: url!)
        var image = UIImage(data: data!)
        return image!
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.mapView.delegate = self
        var span = MKCoordinateSpanMake(0.01, 0.01)
        
        if let resturant = resturant {
            region = MKCoordinateRegion(center: resturant.coordinate, span: span)
            
            mapView.setRegion(region!, animated: true)
            mapView.layer.cornerRadius = 5
            mapView.layer.masksToBounds = true
            mapView.layer.borderColor = UIColor.grayColor().CGColor
            mapView.layer.borderWidth = 1.0
            
            // create annotation for each restaurant
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = resturant.coordinate
            annotation.title = resturant.name
            annotation.subtitle = resturant.address
            mapView.addAnnotation(annotation)
        }
    }
    func getDirections() {
        //CLLocationManager.requestAlwaysAuthorization()
        
        var destinationCoords = CLLocationCoordinate2DMake(resturant!.coordinate.latitude, resturant!.coordinate.longitude)
        var placeMark = MKPlacemark(coordinate: destinationCoords, addressDictionary: nil)
        let request = MKDirectionsRequest()
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        request.setDestination(MKMapItem(placemark: placeMark))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
                println("Error getting directions")
            } else {
                self.showRoute(response)
            }
            
        })
    }
    @IBAction func directionsToRestaurant(sender: AnyObject) {
        

        self.getDirections()
       
        
    }
    

    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes as! [MKRoute] {
            
            mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                println(step.instructions)
            }
        }
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance( userLocation.location.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay
        overlay: MKOverlay!) -> MKOverlayRenderer! {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.orangeColor()
            renderer.lineWidth = 5.0
            return renderer
    }
    
    @IBAction func callRestaurant(sender: UIButton) {
        
        println(resturant?.phoneNumber)
       
        
    }
}
