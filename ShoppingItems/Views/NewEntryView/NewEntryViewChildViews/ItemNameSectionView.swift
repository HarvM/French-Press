import SwiftUI
import SwiftData

struct ItemNameSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newShoppingItem: ShoppingItem
    @Environment(\.modelContext) private var context

    var body: some View {
        TextField(stringStore.typeTheItemHere, 
                  text: $newShoppingItem.itemTitleWithTextLimit.text)
            .frame (height: 50)
            .multilineTextAlignment(.leading)
            .font(.custom(DefaultFont.defaultFont.rawValue, 
                          size: 16,
                          relativeTo: .headline))
        /// Will display the number of characters already typed and the limit
        Text("\(newShoppingItem.itemTitleWithTextLimit.text.count)|30")
            .font(.custom(DefaultFont.defaultFont.rawValue, 
                          size: 16,
                          relativeTo: .headline))
            .foregroundColor(.gray)
    }
}

class ShoppingItem: ObservableObject {
    init(itemTitleWithTextLimit: TextLimit = TextLimit(limit: 30)) {
        self.itemTitleWithTextLimit = itemTitleWithTextLimit
    }
    @Published var itemTitleWithTextLimit = TextLimit(limit: 30)
}

//
//struct NewShoppingItemSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemSectionView()
//    }
//}
