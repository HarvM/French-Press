//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    enum DetailViewImages: String {
        case appIconNavBar = "appHeader"
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
                Color("backgroundBlue")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Section {
                    Text ("\(itemToBeDisplayed.itemToBeAdded)")
                        .font(.custom("Futura", size: 35, relativeTo: .headline))
                        .lineLimit(2)
                        .foregroundColor(.yellow)
                    }
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: 400, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .top)
                    Section {
                    Text("\(itemToBeDisplayed.notesOnItem)")
                        .foregroundColor(.white)
                        .font(.custom("Futura", size: 25, relativeTo: .headline))
                    }
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: 400, minHeight: 600, idealHeight: 700, maxHeight: 800, alignment: .center)
                }
                .multilineTextAlignment(.center)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
                .padding(.top, 20)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Henlo")
    }
}
