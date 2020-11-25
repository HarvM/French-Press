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
    case sorryShrug = "🤷🏻‍♂️"
}

enum Data: String {
    case
}

///View that will let the user select the amount of the item they want and also add any notes that they need
struct NewEntryView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let characterEntryLimit = 60
    let generator = UINotificationFeedbackGenerator()
    @ObservedObject var newShoppingItem = TextLimit(limit: 30)
    @ObservedObject var notesOnItem = TextLimit(limit: 60)
    @ObservedObject var quantitySelected = TextLimit(limit: 6)
    @State var quantityOfItem: Int = 1
    @State var isShowingContentView = false
    @State var showAlert = false
    @State var selectedMeasurement = 0
    let measurementFound = ["packs"," liters", "pints","grams","kilograms","wee bags", "punnet", "bottles", "thingys", "doodaahs", "jars", "packets"]
    
    //add feature where the user's input into the notesOnItem would get the weight and then not display the quantityOfItem on the ContentView
    //How to search through string: two different vars attack the String with one pulling numbers ("6"/"six") and the other quantities ("ml"/"kg"/etc) and then match them off based off the quantity selected
    //Feels more elegant than having another data entry point for the user to endure
    
    //MARK: - Body the UI that will have a Stepper at the top, Save and Back Button, and somewhere to add extra notes too
    var body: some View {
        ZStack{
            Color("backgroundDefault")
                .edgesIgnoringSafeArea(.all)
            Form {
                //MARK: - TextEditor - Item entry (Main) section
                Section (header: Text("What would you like?")
                            .foregroundColor(.yellow)
                            .truncationMode(.head)) {
                    HStack {
                        ///$newShoppingItem to get the binding to the state newShoppingItem
                        TextEditor(text: $newShoppingItem.text)
                            .frame (height: 40)
                            .multilineTextAlignment(.leading)
                        ///Will display the number of characters already typed and the limit
                        Text("\(self.newShoppingItem.text.count)|30")
                            .font(.custom("Futura", size: 14, relativeTo: .headline))
                            .foregroundColor(.gray)
                    }
                    .font(.headline)
                }
                
                //MARK: - Stepper Section
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    VStack {
                        TextField("Type quantity here",text: $quantitySelected.text)
                            .frame (height: 40)
                            .multilineTextAlignment(.leading)
                            .keyboardType(.numberPad)
                        
                    }
                        Picker(selection: $selectedMeasurement, label: Text("")) {
                            ForEach(0 ..< measurementFound.count) {
                                Text(self.measurementFound[$0])
                                    .frame(height: 40)
                            }
                        }
                       
                }
                
                //MARK: - TextEditor (Extra Notes) Section
                Section(header: Text("Extra Notes")
                            .foregroundColor(.yellow)
                ){
                    HStack {
                        TextEditor( text: $notesOnItem.text)
                            .frame(height: 220)
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                        Spacer()
                        ///Will display the number of characters already typed and the limit
                        Text("\(self.notesOnItem.text.count)|60")
                            .font(.custom("Futura", size: 14, relativeTo: .headline))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            
            //MARK: - Save Button
            VStack {
                Spacer()
                HStack {
                    Button(action: self.saveNewEntry, label: {
                        Image(DetailViewImages.saveButtonImage.rawValue)
                            .frame(width: 60, height: 60)
                    })
                    .background(Color.white)
                    .cornerRadius(38.5)
                    .padding(.bottom, 30)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
        }
        .background(Color("backgroundDefault"))
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Heads Up"),
                  message: Text("Sorry but there has to be an item to add"),
                  dismissButton: .default(Text("Noted"))
            )
        }
    }
    
    //MARK: - Function
    private func saveNewEntry() {
        
        ///Removes the whitespace and newLines from the item as it messes with how the name is displayed on the ContentView
        let trimmedItem = self.newShoppingItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNote = self.notesOnItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedQuantity = self.quantitySelected.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let chosenMeasurement = self.measurementFound[self.selectedMeasurement]
        print("Here you go: \(chosenMeasurement)")
        
        ///There has to be a value within the "itemsToBeAdded" or else nothing will be saved
        if self.newShoppingItem.text == "" {
            self.showAlert = true
        }
        else {
            ///Will get the new item and then place it within the CoreData under the attribute of itemToBeAdded
            let shoppingItemNew = ShoppingItems(context: self.managedObjectContext)
            self.managedObjectContext.performAndWait {
                shoppingItemNew.itemToBeAdded = trimmedItem
                shoppingItemNew.notesOnItem = trimmedNote
                shoppingItemNew.quantitySelected = trimmedQuantity
                shoppingItemNew.preferredMeasurement = chosenMeasurement
                //                shoppingItemNew.selectedMeasurement = Int16(self.selectedMeasurement)
                self.isShowingContentView = true
                
                ///Will save the new entry but if not the user will be notified that there was an issue saving to to the device
                do {
                    try self.managedObjectContext.save()
                } catch {
                    Alert(title: Text("Sorry \(DetailViewImages.sorryShrug.rawValue)"), message: Text("Please try again"), dismissButton: .default(Text("Okay")))
                }
                
                ///Resets the newShoppingItem back to being blank
                newShoppingItem.text = ""
                notesOnItem.text = ""
                
                ///Haptic feedback for when the user has tapped on the Add/Plus button
                self.generator.notificationOccurred(.success)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


