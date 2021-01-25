//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import SpriteKit

struct DetailView: View {
    
    enum DetailViewImages: String {
        case placeholderImage = "appHeader" ///Placeholder image that's displayed when there are no entries
    }
    
    ///Futura font 
    enum CustomFont: String {
        case defaultFont = "SF Pro"
    }
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State private var hasData = false
    
    //MARK: - Body of the view
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Text ("\(itemToBeDisplayed.itemToBeAdded)")
                        .font(.custom(CustomFont.defaultFont.rawValue, size: 35, relativeTo: .headline))
                        .lineLimit(3)
                        .foregroundColor(.yellow)
                        .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                }
                .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .top)
                .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                Section {
                    Text("\(itemToBeDisplayed.notesOnItem)")
                        .foregroundColor(.white)
                        .font(.custom(CustomFont.defaultFont.rawValue, size: 25, relativeTo: .headline))
                        .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                }
                .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
            }
            .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 400, idealHeight: 700, maxHeight: 800, alignment: .top)
            .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
        }
        .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
        .onAppear(perform: self.placeholderAppear)
        .multilineTextAlignment(.center)
        .allowsTightening(true)
        .minimumScaleFactor(0.9)
        .navigationViewStyle(StackNavigationViewStyle()) ///removes iPad split screen
    }
    
    private func placeholderAppear() {
        DispatchQueue.main.async {
            if itemToBeDisplayed.notesOnItem.isEmpty && itemToBeDisplayed.itemToBeAdded.count >= 1 {
                Image(DetailViewImages.placeholderImage.rawValue)
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .bottom)
                    .scaledToFit()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        DetailView(itemToBeDisplayed:)
        EmptyView()
    }
}
