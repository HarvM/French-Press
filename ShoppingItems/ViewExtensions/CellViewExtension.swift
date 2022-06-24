//
//  CellViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 04/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import Foundation

extension CellView {
    
    // MARK: - Func for single/multiple items
    public func singleOrMultiple() {
        /// Finally seen that it was worth using a @State instead for the finalOutput
        if quantitySelected == "\(stringStore.one)" || preferredMeasurement == "\(stringStore.treatEmoji)" {
            return
        } else {
            finalOutput = self.multipleItems
        }
    }
}
