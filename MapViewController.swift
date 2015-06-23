//
//  MapViewController.swift
//  Yelp
//
//  Created by tho dang on 2015-06-21.
//  Copyright (c) 2015 Jerry Su. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    
   override func  viewDidLoad() {
    super.viewDidLoad()
    setUp()
    
    }
    
    func setUp() {
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
      
        mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
    }
    
//    func displayLocation(location:CLLocation){
//        
//        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)),animated: true)
//        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locationPinCoord
//        mapView.addAnnotation(annotation)
//        mapView.showAnnotations( [annotation], animated: true) }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
