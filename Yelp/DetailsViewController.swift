

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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
        
        restaurantNameLabel.text = resturant?.name
        restaurantAddress.text = resturant?.address
        restaurantCategories.text = resturant?.categories
        if phoneNumber !== nil{
            phoneNumber.text = resturant?.phoneNumber}
        
        if let number = resturant?.imageUrl {
            self.restaurantImage.sd_setImageWithURL(NSURL(string: number))
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
        mapView.addAnnotation(resturant)
        
        var span = MKCoordinateSpanMake(0.01, 0.01)
        
        if let resturant = resturant {
            var region = MKCoordinateRegion(center: resturant.coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            
            // create annotation for each restaurant
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = resturant.coordinate
            annotation.title = resturant.name
            annotation.subtitle = resturant.address
            mapView.addAnnotation(annotation)
            
        }
        
        
        
    }

}
