//
//  DetailsViewController.swift
//  Yelp
//
//  Created by tho dang on 2015-06-17.
//  Copyright (c) 2015 Jerry Su. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var restaurantRating: UILabel!
    
    @IBOutlet weak var restaurantCategories: UILabel!
    
    @IBOutlet weak var openOrCloseLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var restaurantAddress: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var directionButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
