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
struct DetailView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var numberOf = ShoppingItem()
    @ObservedObject var extraNotesOnItem = TextLimit(limit: 200)
    @State private var fullText: String = ""
    @State private var isShowingContentView = false
    
    //MARK: - Body the UI that will have a Stepper at the top, Save and Back Button, and somewhere to add extra notes too
    var body: some View {
        ZStack{
            Color.init(red: 0.07, green: 0.45, blue: 0.87)
                .edgesIgnoringSafeArea(.all)
            Form {
                //MARK: - Stepper Section
                Section (header: Text("How Many Would You Like?")
                            .foregroundColor(.yellow)) {
                    Stepper ("Quantity: \(numberOf)",
                             value: $numberOf.quantityOfItem, in: 1...14)
                }
                
                //MARK: - TextEditor Section
                Section(header: Text("Extra Notes")
                            .foregroundColor(.yellow)
                ){
                    TextEditor (text: $fullText)
                }
                .foregroundColor(.black)
                .lineSpacing(10)
                .lineLimit(5)
                .disableAutocorrection(true)
            }
            
            //MARK: - Save Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: self.save,
                           label: {
                            Image(DetailViewImages.saveButtonImage.rawValue)
                                .frame(width: 80,
                                       height: 80)
                           })
                        .background(Color.white)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                }
            }
        }
        .background(Color.init(red: 0.07,
                               green: 0.45,
                               blue: 0.87))
    }
    
    private func save() {
        let extraDetails = ShoppingItem(context: self.managedObjectContext)
        self.managedObjectContext.performAndWait {
            
            extraDetails.notesOnItem = self.fullText
            self.isShowingContentView = true
            
            ///Error will be displayed if there's an issue with the new contact data being saved
            do {
                try self.managedObjectContext.save()
            } catch {
                Alert(title: Text("Unable to save that one"), message: Text("Please try again"), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


