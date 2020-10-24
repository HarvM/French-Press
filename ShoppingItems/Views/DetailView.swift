//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

//View that will let the user select the amount of the item they want and also add any notes that they need
struct DetailView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State var numberOf = 0
    @ObservedObject var numberOfItem = NumberOfItemsNeeded()
    
    //MARK: - Body the UI that will have a Stepper at the top, Save and Back Button, and somewhere to add extra notes too
    var body: some View {
        NavigationView {
            Form {
                
            //MARK: - Stepper Section
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    Stepper ("Quantity: \(numberOf)", value: $numberOf, in: 1...14)
                }
            }
            .background(Color.init(red: 0.07, green: 0.45, blue: 0.87))
            .foregroundColor(.black)
            
//            //MARK: - Note Taking Section
//            Section {
//
//            }
//
//            //MARK: - Save and Back Button
//            Section {
//
//            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


