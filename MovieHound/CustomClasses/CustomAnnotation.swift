//
//  CustomAnnotation.swift
//  Day17MapKit&CoreLocation
//
//  Created by admin on 7/7/16.
//  Copyright © 2016 Micheal Hannan. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: MKPointAnnotation
{
    var rating : String = ""
    var icon : String = ""
    var price : String = ""
    
    override init()
    {
        super.init()
        title = ""
        subtitle = ""
        coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
}
