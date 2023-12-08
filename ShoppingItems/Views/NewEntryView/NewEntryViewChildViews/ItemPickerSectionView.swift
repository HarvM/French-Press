import SwiftUI

struct ItemPickerSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var selectedMeasurement: ItemMeasurement

    var body: some View {
        Picker(selection: $selectedMeasurement.userSelectedMeasurement, label: Text("")) {
            ForEach(0 ..< 21, id: \.self) {
                Text(self.stringStore.measurementFound[$0])
                    .frame(height: 40)
            }
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: 16,
                          relativeTo: .headline))
        }
        .pickerStyle(DefaultPickerStyle())
        .foregroundColor(.red)
    }
}

class ItemMeasurement: ObservableObject {
    @Published var userSelectedMeasurement = 0
}

struct NewEntryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let mockShoppingItemMeasurement = ItemMeasurement()
        ItemPickerSectionView(selectedMeasurement: mockShoppingItemMeasurement)
    }
}

