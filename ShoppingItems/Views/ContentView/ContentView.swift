import SwiftUI
import Foundation
import SwiftData

struct ContentView: View {
    
    // MARK: - Properties
    let stringStore = StringStore()
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
            EmptyListView()
        } else {
            PopulatedView()
        }
    }

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
