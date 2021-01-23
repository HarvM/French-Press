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

/// Futura font
enum CustomFontDetailView: String {
    case defaultFont = "SF Pro"
}

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
        VStack {
            Form {
                //MARK: - TextEditor - Item entry (Main) section
                Section (header: Text("What would you like?")
                            .foregroundColor(.yellow)
                            .truncationMode(.head)) {
                    HStack {
                        ///$newShoppingItem to get the binding to the state newShoppingItem
                        TextField("Type the item here", text: $newShoppingItem.text)
                            .frame (height: 40)
                            .multilineTextAlignment(.leading)
                            .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                        ///Will display the number of characters already typed and the limit
                        Text("\(self.newShoppingItem.text.count)|30")
                            .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                            .foregroundColor(.gray)
                    }
                    .font(.headline)
                }
                
                //MARK: - Picker Section for quantity & quantity type
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    VStack {
                        TextField("Type quantity here",text: $quantitySelected.text)
                            .frame (height: 40)
                            .multilineTextAlignment(.leading)
                            .keyboardType(.decimalPad)
                            .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                    }
                    Picker(selection: $selectedMeasurement, label: Text("")) {
                        ForEach(0 ..< measurementFound.count) {
                            Text(self.measurementFound[$0])
                                .frame(height: 40)
                        }
                        .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .foregroundColor(.red)
                }
                
                //MARK: - TextEditor (Extra Notes) Section
                Section(header: Text("Extra Notes")
                            .foregroundColor(.yellow)) {
                    HStack {
                        ///I'd ideally love to have this as TextEditor instead to allow more detailed notes but getting the keyboard to hide has been a 'mare
                        TextField("Type here", text: $notesOnItem.text)
                            .frame(height: 50)
                            .multilineTextAlignment(.leading)
                            .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                        Spacer()
                        ///Will display the number of characters already typed and the limit
                        Text("\(self.notesOnItem.text.count)|40")
                            .font(.custom(CustomFontDetailView.defaultFont.rawValue, size: 16, relativeTo: .headline))
                            .foregroundColor(.gray)
                    }
                }
            }
            ///Getting this to work was a nightmare. Found something useful for a TextField but done sweet FA on a TextEditor
            ///Uses the AdaptsToKeyboard struct to bump the screen up when the user brings up the keyboard
            .modifier(AdaptsToKeyboard())
            .alert(isPresented: $showAlert) { () -> Alert in
                Alert(title: Text("Sorry"),
                      message: Text("There has to be an item to add"),
                      dismissButton: .default(Text("👍🏼"))
                      ///Bit tacky using the thumbs up but with the colour across the app being white with the init, it couldn't be changed here (tried .foregroundColour)
                )
            }
            .navigationBarItems(trailing:Button(action: self.saveNewEntry, label: {
                Image(ContentViewImages.plusImage.rawValue)
                    .frame(width: 35, height: 35)
                    .cornerRadius(38.5)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
            }))
        }
        .background(Color("defaultBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
    
    ///Atttempt at getting the background color to sit properly as it should
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("defaultBackground"))
    }
    
    //MARK: - Function (saves the user's item [item name, quantity, measurement, and extra notes]
    
    private func saveNewEntry() {
        DispatchQueue.main.async {
            ///Removes the whitespace and newLines from the item as it messes with how the name is displayed on the ContentView
            let trimmedItem = self.newShoppingItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedNote = self.notesOnItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedQuantity = self.quantitySelected.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let chosenMeasurement = self.measurementFound[self.selectedMeasurement]
            
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
}


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}


