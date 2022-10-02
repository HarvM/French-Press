//
//  ContentView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//
import SwiftUI
import Foundation

struct ContentView: View {
    
    // MARK: - Properties
    @State var isEditing = false
    @State var showHamburgerMenu = false
    @ObservedObject var listStore: ShoppingItemStore
    let generator = UINotificationFeedbackGenerator()
    let stringStore = StringStore()
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode
    @Environment (\.colorScheme) var colorScheme
    @FetchRequest(entity: ShoppingItems.entity(), sortDescriptors:
                    [NSSortDescriptor (keyPath: \ShoppingItems.order, ascending: true)])
    var shoppingItemEntries: FetchedResults<ShoppingItems>
    
    // MARK: Main body of the view
    var body: some View {
        ZStack {
            Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
            ListView
        }
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - ViewBuilder - Logic to decide which view to use
    @ViewBuilder
    var ListView: some View {
        /// If no shoppingItemEntries on the list then display the placeholder image
        if shoppingItemEntries.count == 0 {
            EmptyListView
        } else {
            /// Will show the view with the shoppingItems that the user has input
            PopulatedView
        }
    }
    
    // MARK: - EmptyListView - used upon initial launch and should the user have no items
    var EmptyListView: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        Image(ContentViewImages.appIcon.rawValue)
                            .padding(.top, geometry.size.height/2)
                        Spacer()
                    } /// End of VStack
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
                
                // MARK: - NavigationBarItems: Leading item will be the HamburgerMenu button that lets the user access the settings, the trailing item: let's the user add a new item to the CoreData/list
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment:.center)
                            .edgesIgnoringSafeArea(.all)
                        ){
                            /// Will lead use to the NewEntryView
                            Image(ContentViewImages.plusImage.rawValue)
                                .frame(width: 35, height: 35)
                                .cornerRadius(.infinity)
                        }
                    }
                } /// End of toolbar
                .foregroundColor(.white)
                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
            } /// End of ZStack
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - PopulatedView
    /// This view will hold the List that displays the items that the user has input and kept in CoreData
    var PopulatedView: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack {
                    if #available(iOS 16.0, *) {
                        List {
                            // MARK: - HStack: how the cells are displayed and populated
                            Section() {
                                ForEach(shoppingItemEntries, id: \.self) {
                                    shoppingItemNew in
                                    HStack {
                                        CellView(itemToBeAdded: shoppingItemNew.itemToBeAdded,
                                                 quantitySelected: shoppingItemNew.quantitySelected,
                                                 preferredMeasurement: shoppingItemNew.preferredMeasurement)
                                        NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItemNew))
                                    } /// End of HStack
                                } /// End of ForEach loop
                                .onDelete(perform: self.deleteItem)
                                .onMove(perform: moveItem)
                            } /// End of Section
                            .listStyle(PlainListStyle())
                            .listRowBackground(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                        } /// End of List
                        .padding(.top) /// Prevents List showing below statusBar
                        .listRowSeparator(.hidden)
                        .scrollContentBackground(.hidden)
                    } else {
                        List {
                            // MARK: - HStack: how the cells are displayed and populated
                            Section() {
                                ForEach(shoppingItemEntries, id: \.self) {
                                    shoppingItemNew in
                                    HStack {
                                        CellView(itemToBeAdded: shoppingItemNew.itemToBeAdded,
                                                 quantitySelected: shoppingItemNew.quantitySelected,
                                                 preferredMeasurement: shoppingItemNew.preferredMeasurement)
                                        NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItemNew))
                                    } /// End of HStack
                                } /// End of ForEach loop
                                .onDelete(perform: self.deleteItem)
                                .onMove(perform: moveItem)
                            } /// End of Section
                            .listStyle(PlainListStyle())
                            .listRowBackground(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                        } /// End of List
                        .padding(.top) /// Prevents List showing below statusBar
                        .listRowSeparator(.hidden)
                    }
                } /// End VStack
                /// Appears to help with the reordering of the List and makes it less laggy when a row is moved
                .id(UUID())
                /// Removes the header and the wee arrow that hides/shows the cells
                .listStyle(PlainListStyle())
                /// Ensures that the list is closer to the top of the window
                .navigationBarTitleDisplayMode(.inline)
                
                // MARK: - NavigationBarItems: Leading item will be the EditButton that lets the user edit the list, the trailing launches MapView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment:.center)
                            .edgesIgnoringSafeArea(.all)
                        ){
                            /// Image of the trailing icon that leads the user to the map
                            Image(ContentViewImages.plusImage.rawValue)
                                .frame(width: 35, height: 35)
                                .cornerRadius(38.5)
                        }
                    }
                } /// End of toolbar
            } /// End of ZStack
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    } /// End of populatedView
    
    init() {
        /// Below is various attempts at getting the from from the Picker to display a different background colour
        UIPickerView.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        UIPickerView.appearance().tintColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        /// Setting the empty/potential cells to the desired colour
        UITableView.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        /// clears navBar to background colour
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        /// removes separator
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        /// Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        /// Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        /// Have to init the listStore with a value
        self.listStore = ShoppingItemStore.init()
        UICollectionView.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
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
        EmptyView()
    }
}
