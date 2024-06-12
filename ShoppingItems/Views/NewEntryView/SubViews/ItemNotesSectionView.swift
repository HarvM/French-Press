import SwiftUI

struct ItemNotesSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var noteOnShoppingItem: ItemNote
    @Environment(\.modelContext) private var context

    var body: some View {
        TextField(stringStore.typeHere,
                  text: $noteOnShoppingItem.notesOnItem.text)
        .modifier(TypeHereStyling())
        Spacer()
        /// Will display the number of characters already typed and the limit
        Text("\(noteOnShoppingItem.notesOnItem.text.count)|40")
            .modifier(NotesOnItemStyling())
    }
}

class ItemNote: ObservableObject {
    init(notesOnItem: TextLimit = TextLimit(limit: 40)) {
        self.notesOnItem = notesOnItem
    }
    @Published var notesOnItem = TextLimit(limit: 40)
}

struct NewShoppingItemNotesView_Previews: PreviewProvider {
    static var previews: some View {
        let mockShoppingItemNote = ItemNote(notesOnItem: TextLimit(limit: 40))
        ItemNotesSectionView(noteOnShoppingItem: mockShoppingItemNote)
    }
}
