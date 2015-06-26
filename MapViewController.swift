
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView: MKMapView?
    var locationManager = CLLocationManager()
    
    
    var resturants: Array<Resturant>?{
        didSet{
            if let mapView = self.mapView {
                mapView.removeAnnotations(mapView.annotations)
                
                    
                
            }
            
        }
    }
    
    
   override func  viewDidLoad() {
    super.viewDidLoad()
    
        setUp()
    }
    override func viewWillAppear(animated: Bool) {
        
        mapView?.delegate = self
        if let resturants = self.resturants {
            self.mapView?.addAnnotations(resturants)
            
        }
    }
    
  
    
    func setUp() {
        self.mapView = MKMapView()
        self.view.addSubview(self.mapView!)
        
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView!.showsUserLocation = true
        
        }
    
    override func viewDidLayoutSubviews() {
        self.mapView?.frame = self.view.bounds;
    }
    
    // zoom in current user location
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
    
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
        self.mapView?.setRegion(region, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backSelected(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            //print("We have been dismissed")
        
           
            
        })
    }
   
}
