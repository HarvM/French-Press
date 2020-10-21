//
//  MapSearchView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 14/05/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import UIKit
import MapKit

struct MapSearchView: UIViewControllerRepresentable {
 class Coordinator: NSObject, MapViewDelegate {
  func saveLocation(placemark: MKPlacemark) {
   print("add placemark" )
  }
    }
func makeCoordinator() -> Coordinator {
  return Coordinator()
    }
func makeUIViewController(context: UIViewControllerRepresentableContext<MapSearchView>) -> MapViewController {
        let mapController = MapViewController()
  
        return mapController
    }
func updateUIViewController(_ uiViewController: MapViewController,
                                context: UIViewControllerRepresentableContext<MapSearchView>) {
  
  uiViewController.delegate = context.coordinator
    }

}
