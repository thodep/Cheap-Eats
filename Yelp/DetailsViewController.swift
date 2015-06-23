

import UIKit
import MapKit

class DetailsViewController: UIViewController,MKMapViewDelegate {
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
    
    var restaurantLabel:String = ""
    var restaurantAddressString: String = ""
    var restaurantImageString:String = ""
    var restaurantImageDetail:UIImageView?
    var restaurantRatingImageDetail:UIImageView?
    var restaurantCategoriesDetail: String = ""
    var urlDataObject:String = ""
    var urlRatingImage:String = ""
    
    var restaurantPhoneNumber: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantNameLabel.text = restaurantLabel
        restaurantAddress.text = restaurantAddressString
        restaurantCategories.text = restaurantCategoriesDetail
        phoneNumber.text = restaurantPhoneNumber
        
        
        restaurantImage.image = myImageObject(urlDataObject)
        ratingImage.image = myImageObject(urlRatingImage)
       

    }
    
    func myImageObject(url:NSString) -> UIImage {
        let url = NSURL(string: url as String)
        let data = NSData(contentsOfURL: url!)
        var image = UIImage(data: data!)
        return image!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
