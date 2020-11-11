////
////  MapView.swift
////  ShoppingItems
////
////  Created by Marc Harvey on 08/05/2020.
////  Copyright © 2020 Marc Harvey. All rights reserved.
////
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
////Will handle displaying the MapView when the user is looking to find their nearest supermarket
//struct MapView: UIViewRepresentable {
//    
//    //MARK: - Properties
//    let locationManager = CLLocationManager()
//    let geocoder = CLGeocoder()
//    let mapView = MKMapView()
//    
//    //MARK: - Coordinator function
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)   ///Sends back an instance of the Coordinator to the Coordinator class
//    }
//    
//    ///This nested class will act as a delegate for the MapView and will be able to pass data to and from SwiftUI
//    final class Coordinator: NSObject, MKMapViewDelegate {
//        var control: MapView
//        
//        init(_ control: MapView) {
//            self.control = control ////This nested class will act as a delegate for the MapView and will be able to pass data to and from SwiftUI
//        }
//    }
//    
//    //MARK: - Configuring the UIViewRepresentable protocol (Will display the current location of the user on the display)
//    func makeUIView(context: Context) -> MKMapView {
//
//        ///Ensures that the only places on interest shown are supermarkets
//        let filter = MKPointOfInterestFilter(including: [.foodMarket])
//        mapView.pointOfInterestFilter = filter
//                
//        ///An example location - could scale this up in the future to have the annotations be the pointsOfInterest from above
//        let annotation = MKPointAnnotation()
//        annotation.subtitle = "Where I should be"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
//        mapView.addAnnotation(annotation)
//        return mapView
//    }
//    
//    //MARK: - UpdateUIView (Makes the delegate of the mapView the coodinator, will have the user's location show as the default location, has the requests for the user to authorise as well)
//    
//    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
//        
//        view.showsUserLocation = true
//        let status = CLLocationManager.authorizationStatus()
//        
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//        
//        ///If the user has agreed to Always/WhenInUse: accuracy is then determined
//        ///Location uses the locationManager to get the user's coordinates
//        ///Span determines the level of focus on the user's area
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//            
//            //NOTE: Will kill any sims but works fine on physical device to get current location
//            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
//            
//            ///Determines the area that the user can view
//            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//            let region = MKCoordinateRegion(center: location, span: span)
//            view.setRegion(region, animated: true)
//        }
//        
//        ///Will subtly display on the map the nearest superstores (Asda, Tesco, Aldi etc)
//        let supermarkets = MKPointOfInterestCategory.foodMarket
//        view.pointOfInterestFilter?.includes(supermarkets)
//    }
//}
