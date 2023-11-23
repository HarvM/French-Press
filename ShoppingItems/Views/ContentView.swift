import SwiftUI
import Foundation
import SwiftData

@available(iOS 17.0, *)
struct ContentView: View {
    
    // MARK: - Properties
    @State var isEditing = false
    @State var showHamburgerMenu = false
    let generator = UINotificationFeedbackGenerator()
    let stringStore = StringStore()
    @Environment (\.presentationMode) var presentationMode
    @Environment (\.modelContext) var modelContext
    @Environment (\.colorScheme) var colorScheme
    @Query var shoppingItemEntries: [ShoppingItems]

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
    /// This view will hold the List that displays the items that the user has input and kept in SwiftData
    var PopulatedView: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack {
                        List {
                            // MARK: - HStack: how the cells are displayed and populated
                            Section() {
                                ForEach(shoppingItemEntries, id: \.self) {
                                    shoppingItem in
                                    HStack {
                                        CellView(itemToBeAdded: shoppingItem.itemToBeAdded,
                                                 quantitySelected: shoppingItem.quantitySelected,
                                                 preferredMeasurement: shoppingItem.preferredMeasurement)
                                        NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItem))
                                    } /// End of HStack
                                }
                                .onDelete(perform: self.deleteItem)
                                .onMove(perform: moveItem)
                            } /// End of Section
                            .frame(alignment: .leading)
                            .listStyle(PlainListStyle())
                            .listRowBackground(Color(BackgroundColours.defaultBackground.rawValue)
                                .edgesIgnoringSafeArea(.all))
                        } /// End of List
                        .padding(.top)
                        .padding(.leading, 20)
                        .listRowSeparator(.hidden)
                } /// End VStack
                .id(UUID())
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                
                // MARK: - NavigationBarItems: Leading item will be the EditButton that lets the user edit the list
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .frame(minWidth: 0, idealWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 0,
                                   idealHeight: 0,
                                   maxHeight: .infinity,
                                   alignment:.center)
                            .edgesIgnoringSafeArea(.all)
                        ){
                            Image(ContentViewImages.plusImage.rawValue)
                                .frame(width: 35,
                                       height: 35)
                                .cornerRadius(38.5)
                        }
                    }
                } /// End of toolbar
            } /// End of ZStack
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    } /// End of populatedView
    
    init() {
        UIPickerView.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        UIPickerView.appearance().tintColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        UITableView.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor(Color(BackgroundColours.defaultBackground.rawValue))
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
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
