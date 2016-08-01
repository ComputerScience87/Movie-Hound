//
//  MovieMapViewController.swift
//  MovieHound
//
//  Created by admin on 7/15/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MovieMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways
        {
            locationManager.requestLocation()
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.mapType = .Standard
            
            if locationManager.location?.coordinate != nil
            {
                let tempLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
                
                manager.getJSONDataMapView(tempLocation)
                {
                    self.addMyAnnotationsToTheMap()
                    
                    let regionCenter = self.locationManager.location!.coordinate
                    let regionSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    let region = MKCoordinateRegion(center: regionCenter, span: regionSpan)
                    self.mapView.setRegion(region, animated: true)
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location : CLLocation = locations.last!
        let eventTimeStamp = location.timestamp
        //How long ago was this event
        let timeBeforeNow = eventTimeStamp.timeIntervalSinceNow
        
        if (timeBeforeNow < 30) {
            NSLog("Latitude %+.6f, longitude %+.6f", location.coordinate.latitude, location.coordinate.longitude)
            
            let regionCenter = location.coordinate
            let regionSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion(center: regionCenter, span: regionSpan)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        if error.code == CLError.LocationUnknown.rawValue
        {
            if let clErr = CLError(rawValue: error.code)
            {
                switch clErr
                {
                    case .LocationUnknown:
                        print("location unknown")
                        let alertController = UIAlertController(title: "GPS Error", message:
                            "It appears we are unable to retrieve your current location. Please ensure your GPS is enabled before proceeding.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    case .Denied:
                        print("denied")
                        let alertController = UIAlertController(title: "GPS Error", message:
                            "It appears the application was denied access to your GPS service. Please ensure your GPS is enabled and allow the application access before proceeding.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    default:
                        print("unknown Core Location error")
                        let alertController = UIAlertController(title: "GPS Error", message:
                            "An Unknown error was encountered while attempted to retrieve your location. Please proceed back in the application and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                }
            }
        }
    }
    
    func startLocationUpdates() {
        //Set the accuracy and distance filter for the location manager
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.activityType = .AutomotiveNavigation
        //Start our updates
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    // Function expected to be used to add the annotatons for local video retailers
    func addMyAnnotationsToTheMap()
    {
        if manager.annotationArray.count > 0
        {
            for place in manager.annotationArray
            {
                mapView.addAnnotation(place)
            }
            
            let regionCenter = locationManager.location?.coordinate
            let regionSpan = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            let region = MKCoordinateRegion(center: regionCenter!, span: regionSpan)
            mapView.setRegion(region, animated: true)
        }
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
