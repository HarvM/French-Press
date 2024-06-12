import SwiftUI
import SwiftData

struct ItemNameSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var selectedShoppingItem: ShoppingItem
    @Environment(\.modelContext) private var context

    var body: some View {
        TextField(stringStore.typeTheItemHere,
                  text: $selectedShoppingItem.itemTitleWithTextLimit.text)
        .modifier(ItemNameStyling())
        /// Will display the number of characters already typed and the limit
        Text("\(selectedShoppingItem.itemTitleWithTextLimit.text.count)|30")
            .modifier(ItemLimitStyling())
    }
}

class ShoppingItem: ObservableObject {
    @Published var itemTitleWithTextLimit = TextLimit(limit: 30)
}

struct NewShoppingItemSectionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var itemToBeAdded = ShoppingItem()
        ItemNameSectionView(selectedShoppingItem: itemToBeAdded)
    }
}
