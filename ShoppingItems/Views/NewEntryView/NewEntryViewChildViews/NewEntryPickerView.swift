import SwiftUI

struct NewEntryPickerView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newSelectedMeasurement: ItemMeasurement
    
    var body: some View {
            Picker(selection: $newSelectedMeasurement.newItemMeasurement, label: Text("")) {
                ForEach(0 ..< stringStore.measurementFound.count) {
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
    @Published var newItemMeasurement = 0
}

//struct NewEntryPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewEntryPickerView()
//    }
//}

