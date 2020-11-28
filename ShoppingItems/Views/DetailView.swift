//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    //Using the Futura font 
    enum CustomFont: String {
        case futuraFont = "Futura"
    }
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State private var hasData = false
    
    //MARK: - Body of the view
    var body: some View {
        
        NavigationView {
            ZStack{
                Color("twoFace")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Section {
                    Text ("\(itemToBeDisplayed.itemToBeAdded)")
                        .font(.custom(CustomFont.futuraFont.rawValue, size: 35, relativeTo: .headline))
                        .lineLimit(2)
                        .foregroundColor(.yellow)
                    }
                    .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .top)
                    Section {
                    Text("\(itemToBeDisplayed.notesOnItem)")
                        .foregroundColor(.white)
                        .font(.custom(CustomFont.futuraFont.rawValue, size: 25, relativeTo: .headline))
                    }
                    .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 400, idealHeight: 700, maxHeight: 800, alignment: .center)
                }
                .multilineTextAlignment(.center)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding(.top, 20)
            }
        }
    }
}

//Keyboard: stop the keyboard from hiding the final TextField on smaller devices.
//The singular/plural of the words - I'd like something a bit cleaner
//Nightmode: still super weird and wrong when in the "day" view so needs adjusted. Weirdly doesn't conform to the colour asset

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Henlo")
    }
}
