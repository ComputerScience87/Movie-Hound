//
//  Manager.swift
//  Day12WebServices
//
//  Created by admin on 6/22/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit
import MapKit

class Manager: NSObject {
    
    var annotationArray : [CustomAnnotation] = []
    var searchMovieResults : [MovieItemClass] = []
    var personalMovieCollection : [MovieItemClass] = []
    
    let fileName = "PersonalCollection.txt"
    
    static let managerSharedInstance = Manager()
    
    var adapter = PlacesAdapter.adapterSharedInstance
    
    private override init(){}
    
    func getJSONDataMapView(senderPoint : CLLocationCoordinate2D, closure: () -> Void)
    {
        print("getJSONDataMapView()")
        adapter.beginParsingJSONMapData(senderPoint)
        {
            tempArray in
            self.annotationArray = tempArray
            closure()
        }
    }
    
    func getJSONDataSearchResults(stringToSearch : String, closure: () -> Void)
    {
        // Get the data from Open Source Movie API
        adapter.beginParsingJSONMovieData(stringToSearch)
        {
            tempArray in
            self.searchMovieResults = tempArray
            closure()
        }
    }
    
    func loadPersonalCollection()
    {
        var filePath : String
        {
            let fileManager = NSFileManager.defaultManager()
            let url = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            return url.URLByAppendingPathComponent(fileName).path!
        }
        
        if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath)
        {
            personalMovieCollection = array as! [MovieItemClass]
        }
    }

    func savePersonalCollection()
    {
        
        var filePath : String
        {
            let fileManager = NSFileManager.defaultManager()
            let url = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! 
            return url.URLByAppendingPathComponent(fileName).path!
        }
        
        if filePath != ""
        {
            NSKeyedArchiver.archiveRootObject(personalMovieCollection, toFile: filePath)
        }
    }
    
}
