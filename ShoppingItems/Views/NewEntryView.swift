//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import CoreData

//View that will let the user select the amount of the item they want and also add any notes that they need
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
    @State var areTreatsAllowed = true
    let stringStore = StringStore()
    let itemSizeMax: Int = 30
    let noteSizeMax: Int = 40
    let foregroundColourYellow = Color.yellow
    let foreGroundColourGrey = Color.gray
    
    //MARK: - Body the UI that will have a Form (Item Entry, Stepper, and Notes) and a Save Button (bottom of view)
    var body: some View {
        ZStack {
            Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 45)
                Form {
                    //MARK: - TextEditor - Item entry (Main) section
                    
                    Section (header: Text(stringStore.whatWouldYouLike)
                                .foregroundColor(foregroundColourYellow)
                                .truncationMode(.head)
                                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))) {
                        VStack {
                            HStack {
                                EnterItemView()
                            }
                            .font(.headline)
                        } ///End of Section
                        .padding(5)
                    }
                    
                    //MARK: - Picker Section for quantity & quantity type
                    Section (header: Text(stringStore.howManyWouldYouLike)
                                .foregroundColor(foregroundColourYellow)
                                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))) {
                        VStack {
                            QuantityView()
                        }
                        PickerView()
                    }/// End of Section
                                .padding(2)
                    
                    //MARK: - TextEditor (Extra Notes) Section
                    Section(header: Text(stringStore.extraNotes)
                                .foregroundColor(foregroundColourYellow)
                                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))) {
                        HStack {
                            TextField(stringStore.typeHere, text: $notesOnItem.text)
                                .frame(height: 50)
                                .multilineTextAlignment(.leading)
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                            Spacer()
                            ///Will display the number of characters already typed and the limit
                            Text("\(self.notesOnItem.text.count)|\(noteSizeMax)")
                                .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
                                .foregroundColor(foreGroundColourGrey)
                        }
                    } ///End of section
                                .padding(2)
                } ///End of Form
                .clipped()
                .padding(.top)
                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                ///Uses the AdaptsToKeyboard struct to bump the screen up when the user brings up the keyboard
                .modifier(AdaptsToKeyboard())
                
                //MARK: - Button that will save the user's entry - sits at the bottom of the view
                HStack(alignment: .center, spacing: 10) {
                    Button(action: self.saveNewEntry, label: {
                        SaveButtonView()
                    })
                        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                        .alert(isPresented: $showAlert) { () -> Alert in
                            Alert(title: Text(stringStore.oneMoment),
                                  message: Text(stringStore.makeSure),
                                  dismissButton: .default(Text(ContentViewImages.thumbsUp.rawValue))
                            )
                        }
                }///End of HStack
                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            }///End of VStack
            .toolbar { ///Using toolbar to place in the Treat button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: self.weeTreat, label: {
                        Text("\(stringStore.treatEmoji)")
                    })
                }
            } ///End of toolbar
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
        } ///End of ZStack
        .edgesIgnoringSafeArea(.all)
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    } ///End of body
} ///End of View


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}


