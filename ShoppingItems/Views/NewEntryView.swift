//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import CoreData

///Image that is used for the floating save button
enum DetailViewImages: String {
    case saveButtonImage = "plusIcon" ///Will take user to the ContentView
}

///View that will let the user select the amount of the item they want and also add any notes that they need
struct NewEntryView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let characterEntryLimit = 60
    let generator = UINotificationFeedbackGenerator()
    @ObservedObject var newShoppingItem = TextLimit(limit: 30)
    @ObservedObject var notesOnItem = TextLimit(limit: 120)
    @State var quantityOfItem: Int = 1
    @State var isShowingContentView = false
    
    //MARK: - Body the UI that will have a Stepper at the top, Save and Back Button, and somewhere to add extra notes too
    var body: some View {
        ZStack{
            Color.init(red: 0.07, green: 0.45, blue: 0.87)
                .edgesIgnoringSafeArea(.all)
            Form {
                //MARK: - TextEditor - Item entry (Main) section
                Section (header: Text("What would you like?")
                            .foregroundColor(.yellow)) {
                    HStack {
                        ///$newShoppingItem to get the binding to the state newShoppingItem
                        TextEditor(text: $newShoppingItem.text)
                            .frame (height: 40)
                            .multilineTextAlignment(.leading)
                    }
                    .font(.headline)
                }
                
                //MARK: - Stepper Section
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    Stepper ("Quantity: \(quantityOfItem)",
                             value: $quantityOfItem, in: 1...70)
                        .frame(height: 40)
                        .font(.headline)
                }
               
                
                //MARK: - TextEditor (Extra Notes) Section
                Section(header: Text("Extra Notes")
                            .foregroundColor(.yellow)
                ) {
                    TextEditor( text: $notesOnItem.text)
                        .frame(height: 120)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                }
                .foregroundColor(.black)
                .disableAutocorrection(true)
                           }
            .padding(20)
            
            //MARK: - Save Button
            VStack {
                Spacer()
                HStack {
                    Button(action: self.saveNewEntry, label: {
                        Image(DetailViewImages.saveButtonImage.rawValue)
                            .frame(width: 100, height: 60)
                    })
                    .background(Color.white)
                    .cornerRadius(38.5)
                    .padding(.bottom, 30)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
        }
        .background(Color.init(red: 0.07, green: 0.45, blue: 0.87))
    }
    
    //MARK: - Functions
    private func saveNewEntry() {
        ///Will get the new item and then place it within the CoreData under the attritbute of itemToBeAdded
        let shoppingItemNew = ShoppingItems(context: self.managedObjectContext)
        self.managedObjectContext.performAndWait {
            shoppingItemNew.itemToBeAdded = self.newShoppingItem.text
            shoppingItemNew.notesOnItem = self.notesOnItem.text
            ///Note: had to explicity state Int16 both here and in the extension of the model
            shoppingItemNew.quantityOfItem = Int16(self.quantityOfItem)
            self.isShowingContentView = true
            
            ///Save button will kick the user back to the ContentView()
            NavigationLink(destination: ContentView(),
                           isActive: $isShowingContentView) {
                EmptyView() }
            
            ///Will just print the error for the time being should it be unable to save the new entries
            do {
                try self.managedObjectContext.save()
            } catch {
                Alert(title: Text("Unable to save that one"), message: Text("Please try again"), dismissButton: .default(Text("Okay")))
            }
            ///Resets the newShoppingItem back to being blank
            newShoppingItem.text = ""
            notesOnItem.text = ""
//            quantityOfItem = 0
            
            ///Haptic feedback for when the user has tapped on the Add/Plus button
            self.generator.notificationOccurred(.success)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


