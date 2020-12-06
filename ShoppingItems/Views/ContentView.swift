//
//  ContentView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//
import SwiftUI
import MapKit

///Images used across the ContentView
enum ContentViewImages: String {
    case plusImage = "plusIcon" ///On the textEntry field and will let the user add an item
}

struct ContentView: View {
    //MARK: - Properties
    let generator = UINotificationFeedbackGenerator()
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(entity: ShoppingItems.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \ShoppingItems.itemToBeAdded, ascending: true),
        NSSortDescriptor(keyPath: \ShoppingItems.notesOnItem, ascending: true),
        NSSortDescriptor(keyPath: \ShoppingItems.quantitySelected, ascending: true),
        NSSortDescriptor(keyPath: \ShoppingItems.preferredMeasurement, ascending: true)
    ])
    var shoppingItemEntries: FetchedResults<ShoppingItems>
    
    //MARK: - Body of the view
    var body: some View {
        NavigationView {
            ZStack{
                Color("defaultBackground")
                    .edgesIgnoringSafeArea(.all)
                List {
                    //MARK: - HStack: how the cells are displayed and populated
                    Section () {
                        ForEach(shoppingItemEntries, id: \.self) {
                            shoppingItemNew in
                            HStack {
                                CellView(itemToBeAdded: shoppingItemNew.itemToBeAdded, quantitySelected: shoppingItemNew.quantitySelected,
                                         preferredMeasurement: shoppingItemNew.preferredMeasurement)
                                NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItemNew))
                            }
                        }
                        .onDelete(perform: self.deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    .listRowBackground(Color("defaultBackground"))
                }
                
                //MARK: - NavigationBarItems: Leading item will be the EditButton that lets the user edit the list, the trailing launches MapView
                .navigationBarItems(leading: EditButton(),
                                    trailing: NavigationLink(destination: NewEntryView()
                                                                .navigationBarTitle("Add Item")
                                                                .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment:.center)
                                                                .edgesIgnoringSafeArea(.all)
                                    ){
                                        ///Image of the trailing icon tha leads the user to the map
                                        Image(ContentViewImages.plusImage.rawValue)
                                            .frame(width: 35, height: 35)
                                            .cornerRadius(38.5)
                                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                                    })
                .foregroundColor(.white)
                .padding(.trailing, 5)
                .padding(.leading, 5)
                .padding(.top, 5)
                .padding(.bottom, 5)
            }
            ///Removes the split view from iPad versions
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Yer Messages")
            .navigationBarTitleDisplayMode(.inline)
            ///Removes the header and the wee arrow that hides/shows the cells
            .listStyle(PlainListStyle())
        }
    }
    
    //MARK: - Delete Item Function
    private func deleteItem(at indexSet: IndexSet) {
        DispatchQueue.main.async {
        ///When the user wants to delete a cell, the index of the selected cell is found and then removed
        let deleteItem = self.shoppingItemEntries[indexSet.first!]
        self.managedObjectContext.delete(deleteItem)
        
        ///Haptic feedback for when the user taps on Delete
        self.generator.notificationOccurred(.error)
        }
    }
    
    init() {
        ///Below is various attempts at getting the from from the Picker to display a different background colour
        UIListContentView.appearance().backgroundColor = UIColor(Color("defaultBackground"))
        UIPickerView.appearance().backgroundColor = UIColor(Color("defaultBackground"))
        UIPickerView.appearance().tintColor = UIColor(Color("defaultBackground"))
        ///Setting the empty/potential cells to the desired colour
        UITableView.appearance().backgroundColor = UIColor(Color("defaultBackground"))
        UITableView.appearance().separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        UITableViewCell.appearance().backgroundColor = .blue
        ///For the unpopulated cells: the separators will be clear
        UITableView.appearance().separatorColor = .clear
        ///The NavigationBar had a white tint over it after moving the title to .inline but below addresses this and keeps the desired blue
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = .clear
        ///Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        ///Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct KeyboardAvoiderDemo: View {
    @State var text = ""
    var body: some View {
        VStack {
            TextField("Demo", text: self.$text)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {}
        .onLongPressGesture(
            pressing: { isPressed in if isPressed { self.endEditing() } },
            perform: {})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
