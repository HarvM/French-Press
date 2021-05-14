//
//  CellViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 04/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import Foundation

extension CellView {
    //MARK: - Func for single/multiple items
    public func singleOrMultiple() {
        ///I feel like there's a better way to do this but this is how I got it working
        ///Will look into changing the quantity at the NewEntryView to a float to allow a range between 0 and 1.9 instead
        ///Finally seen that it was worth using a @State instead for the finalOutput
        if quantitySelected == "1" || preferredMeasurement == "🎁" {
            return
        } else {
            finalOutput = self.multipleItems
        }
    }
}
