//
//  Placemark.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/05/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation
import MapKit

struct Placemark {
    let locationName: String
    let thoroughfare: String
    
    init(item: MKMapItem) {
        var locationString: String = ""
        
        if let name = item.name {
            locationString += "\(name)"
        }
        
        if let locality = item.placemark.locality, locality != item.name {
            locationString += ", \(locality)"
        }
        
        if let adminArea = item.placemark.administrativeArea,
        adminArea != item.placemark.locality {
            locationString += ", \(adminArea)"
        }
        
        if let country = item.placemark.country, country != item.name {
            locationString += ", \(country)"
        }
        
        locationName = locationString
        thoroughfare = item.placemark.thoroughfare!
    }
}
