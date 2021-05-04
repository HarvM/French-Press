//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import CoreData

/// Futura font
//enum CustomFontDetailView: String {
//    case defaultFont = "SF Pro"
//}

///View that will let the user select the amount of the item they want and also add any notes that they need
struct NewEntryView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let generator = UINotificationFeedbackGenerator()
    @ObservedObject var newShoppingItem = TextLimit(limit: 30)
    @ObservedObject var notesOnItem = TextLimit(limit: 40)
    @ObservedObject var quantitySelected = TextLimit(limit: 6)
    @State var isShowingContentView = false
    @State var showAlert = false
    @State var selectedMeasurement = 0
    let measurementFound = ["pack", "litre", "pint", "gram", "kilogram", "millilitre", "ounce", "pound", "wee bag", "big bag", "bar", "tin", "bottle", "jar", "crate", "multipack", "keg", "tub", "roll", "tube", "punnet", "book", "magazine", "thingy"]
    
    //MARK: - Body the UI that will have a Form (Item Entry, Stepper, and Notes) and a Save Button (bottom of view)
    var body: some View {
        ZStack {
            Color("defaultBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    //MARK: - TextEditor - Item entry (Main) section
                    Section (header: Text("What would you like?")
                                .foregroundColor(.yellow)
                                .truncationMode(.head)
                                .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))) {
                        HStack {
                            ///$newShoppingItem to get the binding to the state newShoppingItem
                            TextField("Type the item here", text: $newShoppingItem.text)
                                .frame (height: 40)
                                .multilineTextAlignment(.leading)
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                            ///Will display the number of characters already typed and the limit
                            Text("\(self.newShoppingItem.text.count)|30")
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                                .foregroundColor(.gray)
                        }
                        .font(.headline)
                    }
                    .padding(2)
                    
                    //MARK: - Picker Section for quantity & quantity type
                    Section (header: Text("How Many Would You Like?")
                                .foregroundColor(.yellow)
                                .background(Color("defaultBackground")
                                                .edgesIgnoringSafeArea(.all))) {
                        VStack {
                            TextField("Type quantity here", text: $quantitySelected.text)
                                .frame (height: 40)
                                .multilineTextAlignment(.leading)
                                .keyboardType(.decimalPad)
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                        }
                        Picker(selection: $selectedMeasurement, label: Text("")) {
                            ForEach(0 ..< measurementFound.count) {
                                Text(self.measurementFound[$0])
                                    .frame(height: 40)
                            }
                            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .foregroundColor(.red)
                    }
                    .padding(2)
                    
                    //MARK: - TextEditor (Extra Notes) Section
                    Section(header: Text("Extra Notes")
                                .foregroundColor(.yellow)
                                .background(Color("defaultBackground")
                                                .edgesIgnoringSafeArea(.all))) {
                        HStack {
                            ///I'd ideally love to have this as TextEditor instead to allow more detailed notes but getting the keyboard to hide has been a 'mare
                            TextField("Type here", text: $notesOnItem.text)
                                .frame(height: 50)
                                .multilineTextAlignment(.leading)
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                            Spacer()
                            ///Will display the number of characters already typed and the limit
                            Text("\(self.notesOnItem.text.count)|40")
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(2)
                }
                ///Getting this to work was a nightmare. Found something useful for a TextField but done sweet FA on a TextEditor
                ///Uses the AdaptsToKeyboard struct to bump the screen up when the user brings up the keyboard
                .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                .modifier(AdaptsToKeyboard())
                //MARK: - Button that will save the user's entry - sits at the bottom of the view
                VStack(alignment: .center, spacing: 10) {
                    Button(action: self.saveNewEntry, label: {
                        Image(ContentViewImages.plusImage.rawValue)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .cornerRadius(38.5)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                            .padding(.bottom, 28) ///Pulls it off the bottom - will adjust if more options are added to the Form
                    })
                    .background(Color("defaultBackground")
                                    .edgesIgnoringSafeArea(.all))
                    .alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text("One moment"),
                              message: Text("Make sure you're entering an item"),
                              dismissButton: .default(Text(ContentViewImages.thumbsUp.rawValue))
                              ///Bit tacky using the thumbs up but with the colour across the app being white with the init, it couldn't be changed here (tried .foregroundColour)
                        )
                    }
                }
                .background(Color("defaultBackground")
                                .edgesIgnoringSafeArea(.all))
            }
            .background(Color("defaultBackground")
                            .edgesIgnoringSafeArea(.all))
        }
    }
}


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}


