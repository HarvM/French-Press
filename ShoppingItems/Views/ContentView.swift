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
    
    @State private var newShoppingItem = ""
    let generator = UINotificationFeedbackGenerator()
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode
    @FetchRequest(fetchRequest: ShoppingItem.getAllShoppingItems()) var shoppingItemsFetch:FetchedResults<ShoppingItem>
    
    //MARK: - Setting the empty/potential cells to the desired blue colour
    init() {
        UITableView.appearance().backgroundColor = .init(red: 0.07, green: 0.45, blue: 0.87, alpha: 1)
        UITableView.appearance().separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        ///For the unpopulated cells: the separators will be clear
        UITableView.appearance().separatorColor = .clear
    }
    
    //MARK: - Body of the view
    var body: some View {
        NavigationView {
            ZStack{
                Color.init(red: 0.07, green: 0.45, blue: 0.87)
                    .edgesIgnoringSafeArea(.all)
                List {
                    //MARK: - HStack that deals with how the cells are displayed and populated
                    Section (header: Text("On The List")
                                .underline()
                                .padding(10)
                                .font(Font.system(size: 25, design: .rounded))
                                .foregroundColor(.yellow)
                                .textCase(.none)
                                .frame(maxWidth: .infinity)
                                .background(Color.init(red: 0.07, green: 0.45, blue: 0.87))
                                .listRowInsets(EdgeInsets()))
                    {
                        ///Populates each cell with an item from the ShoppingItem model and also a NavLink to the picker that will let them determine the amount of an item
                        ForEach(self.shoppingItemsFetch) { shoppingItemNew in
                            HStack {
                                ShoppingItemNewView(itemToBeAdded: shoppingItemNew.itemToBeAdded)
                                NavigationLink ("", destination: DetailView())
                            }
                            ///Removes a desired cell from the list
                        } .onDelete(perform: self.deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    .listRowBackground(Color.init(red: 0.07, green: 0.45, blue: 0.87))
                }
                
                //MARK: - NavigationBarItems: Leading item will be the EditButton that lets the user edit the list, the trailing launches MapView
                .navigationBarItems(leading: EditButton(),
                                    trailing: NavigationLink(destination: NewEntryView()
                                                                .navigationBarTitle("Add Item")
                                                                .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: .center)
                                                                .edgesIgnoringSafeArea(.all)
                                    ){
                                        ///Image of the trailing icon tha leads the user to the map
                                        Image(ContentViewImages.plusImage.rawValue)
                                    })
                .foregroundColor(.white)
                .listRowBackground(Color.init(red: 0.07, green: 0.45, blue: 0.87))
                .padding(.trailing, 5)
                .padding(.leading, 5)
                .padding(.top, 4)
                .padding(.bottom, 4)
            }
            ///Removes the split view from iPad versions
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    //MARK: - Function
    
    private func deleteItem(at indexSet: IndexSet) {
        ///When the user wants to delete a cell, the index of the selected cell is found and then removed
        let deleteItem = self.shoppingItemsFetch[indexSet.first!]
        self.managedObjectContext.delete(deleteItem)
        
        ///Haptic feedback for when the user taps on Delete
        self.generator.notificationOccurred(.error)
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
