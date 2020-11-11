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
    @ObservedObject var extraNotesOnItem = TextLimit(limit: 200)
    @State private var newShoppingItem = ""
    let characterEntryLimit = 60
    let generator = UINotificationFeedbackGenerator()
    @FetchRequest(fetchRequest: ShoppingItem.getAllShoppingItems()) var shoppingItemsFetch:FetchedResults<ShoppingItem>
    @State private var fullText: String = ""
    @State private var isShowingContentView = false
    @State private var quantityOfItem: Int = 0
    
    //MARK: - Body the UI that will have a Stepper at the top, Save and Back Button, and somewhere to add extra notes too
    var body: some View {
        ZStack{
            Color.init(red: 0.07, green: 0.45, blue: 0.87)
                .edgesIgnoringSafeArea(.all)
            Form {
                Section (header: Text("What would you like?")
                            .foregroundColor(.yellow)) {
                                HStack {
                                    ///$newShoppingItem to get the binding to the state newShoppingItem
                                    TextField("Type here", text: self.$newShoppingItem)
                                        
                                        ///If the entered text in this field exceeds 'characterEntryLimit' then the field is disabled
                                        .disabled(newShoppingItem.count > (characterEntryLimit - 1))
                                
                                    ///Have disabled the newShoppingItem text unless there is some text within the field. Button won't add empty entries now
                                    .frame (height: 60)
                                    .disabled(self.newShoppingItem.isEmpty)
                                }
                                .font(.headline)
                            }
                
                //MARK: - Stepper Section
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    Stepper ("Quantity: \(quantityOfItem)",
                             value: $quantityOfItem, in: 1...14)
                        .frame(height: 60)
                }
                
                //MARK: - TextEditor Section
                Section(header: Text("Extra Notes")
                            .foregroundColor(.yellow)
                ){
                    TextEditor (text: $fullText)
                }
                .frame(height: 120)
                .foregroundColor(.black)
                .lineSpacing(10)
                .lineLimit(3)
                .disableAutocorrection(true)
            }
            
            //MARK: - Save Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: self.saveNewEntry, label: {
                            Image(DetailViewImages.saveButtonImage.rawValue)
                                .frame(width: 80, height: 80)
                           })
                        .background(Color.white)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
        }
        .background(Color.init(red: 0.07, green: 0.45, blue: 0.87))
    }
    
    private func saveNewEntry() {
        ///Will get the new item and then place it within the CoreData under the attritbute of itemToBeAdded
        let shoppingItemNew = ShoppingItem(context: self.managedObjectContext)
        shoppingItemNew.itemToBeAdded = self.newShoppingItem
        
        ///Will just print the error for the time being should it be unable to save the new entries
        do {
            try self.managedObjectContext.save()
        } catch {
            Alert(title: Text("Unable to save that one"), message: Text("Please try again"), dismissButton: .default(Text("Okay")))
        }
        ///Resets the newShoppingItem back to being blank
        self.newShoppingItem = ""
        ///Haptic feedback for when the user has tapped on the Add/Plus button
        self.generator.notificationOccurred(.success)
        
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


