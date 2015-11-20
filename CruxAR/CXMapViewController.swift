//
//  MapViewController.swift
//  AugmentedRealityApplication
//
//  Created by Andrew on 2015-10-22.
//  Copyright © 2015 Wikitude. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CXMapViewController: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var coordinates = CLLocation()
    @IBOutlet weak var mapView: MKMapView!
    
    class ARLocations: NSObject, MKAnnotation {
        let title: String?
        let subtitle: String?
        let coordinate: CLLocationCoordinate2D
        
        init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization() }
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            if let locationCoordinates = locationManager.location {
                coordinates = CLLocation(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude) }
            mapView.showsUserLocation = true
        case .Restricted, .Denied:
            print("Not authorized")
        default:
            print("Failed")
        }
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 5.0, regionRadius * 5.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(coordinates)
    }
    
    override func viewWillAppear(animated: Bool) {
        loadLocations( { (success) -> Void in
            if success {
                print("\(locationArray?[0])")
                for locations in locationArray! {
                    let location = ARLocations(title: locations.name!, subtitle: locations.locationDescription!, coordinate: CLLocationCoordinate2D(latitude: locations.latitude!, longitude: locations.longitude!))

                    self.mapView.addAnnotation(location)
                    
                }
            } else {
                print("Goodbye")
            }
        })
        

    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
