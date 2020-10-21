//
//  MapViewAdvance.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 21/05/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import MapKit
import SwiftUI

final class Checkpoint: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapViewAdvance: UIViewRepresentable {
    @Binding var checkpoints: [Checkpoint]
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(checkpoints)
    }
}

struct ContentViewAdvance: View {
    @State var checkpoints: [Checkpoint] = [
        Checkpoint(title: "Jobby", coordinate: .init(latitude: 16.047079, longitude: 108.206230)),
        Checkpoint(title: "Class Place", coordinate: .init(latitude: 21.027763, longitude: 105.834160))
    ]
    
    var body: some View {
        for Checkpoint in checkpoints {
            let annotations = MKAnnotation()
            annotations.title = checkpoints.title
            annotations.coordinate = Checkpoint.coordinate 
        }
    MapViewAdvance(checkpoints: $checkpoints)
    }
}

struct ContentViewAdvance_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewAdvance()
    }
}


