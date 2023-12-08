import SwiftUI

struct ItemQuantitySectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var quantityOfShoppingItem: ItemQuantity
    
    var body: some View {
        TextField(stringStore.typeQuantityHere,
                  text: $quantityOfShoppingItem.newItemQuantity.text)
            .frame (height: 40)
            .multilineTextAlignment(.leading)
            .keyboardType(.decimalPad)
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: 16,
                          relativeTo: .headline))
            .ignoresSafeArea(.keyboard,
                             edges: .bottom)
    }
}

class ItemQuantity: ObservableObject {
    init(newItemQuantity: TextLimit = TextLimit(limit: 6)) {
        self.newItemQuantity = newItemQuantity
    }
    @Published var newItemQuantity = TextLimit(limit: 6)
}

//struct NewShoppingItemQuantityView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemQuantityView(newShoppingItemQuantity: self.newShoppingItemQuantity.newItemQuantity.text)
//    }
//}

