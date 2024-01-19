import SwiftUI
import CoreData

@available(iOS 17.0, *)
struct NewEntryView: View {

    // MARK: Padding enum
    private enum Constants: CGFloat {
        case sectionPadding = 5
        case topStackPadding = 35
    }

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @State var itemToBeAdded = ShoppingItem()
    @State var notesOnItem = ItemNote()
    @State var quantitySelected = ItemQuantity()
    @State var selectedMeasurement = ItemMeasurement()
    @State var isShowingContentView = false
    @State var showingAlert = false
    @Environment(\.modelContext) var context
    let stringStore = StringStore()
    let generator = UINotificationFeedbackGenerator()

    //  View that contains a Form (Item Entry, Stepper, and Notes) and a Save Button (bottom of view)
    var body: some View {
        ZStack {
            Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: Constants.topStackPadding.rawValue)
                Form {
                    // MARK: - TextEditor - Item entry (Main) section
                    Section (header: Text(stringStore.whatWouldYouLike)
                        .modifier(TitleModifier())) {
                            VStack {
                                HStack {
                                    ItemNameSectionView(selectedShoppingItem: itemToBeAdded)
                                }
                                .font(.headline)
                            } /// End of Section
                            .padding(Constants.sectionPadding.rawValue)
                        }
                    // MARK: - Picker Section for quantity & quantity type
                    Section (header: Text(stringStore.howManyWouldYouLike)
                        .modifier(TitleModifier())) {
                            VStack {
                                ItemQuantitySectionView(quantityOfShoppingItem: quantitySelected)
                            }
                            ItemPickerSectionView(selectedMeasurement: selectedMeasurement)
                                .padding(Constants.sectionPadding.rawValue)
                        }
                    // MARK: - TextEditor (Extra Notes) Section
                    Section(header: Text(stringStore.extraNotes)
                        .modifier(TitleModifier())) {
                            HStack {
                                ItemNotesSectionView(noteOnShoppingItem: notesOnItem)
                                    .padding(Constants.sectionPadding.rawValue)
                            }
                        } /// End of section
                } ///End of Form
                .modifier(FormModifier())
                // MARK: - Button that will save the user's entry - sits at the bottom of the view
                HStack(alignment: .center) {
                    Button(action: { self.saveShoppingitem(itemToBeAdded: itemToBeAdded.itemTitleWithTextLimit.text,
                                                           notesOnItem: notesOnItem.notesOnItem.text,
                                                           quantitySelected: quantitySelected.newItemQuantity.text,
                                                           preferredMeasurement: String(self.stringStore.measurementFound[selectedMeasurement.userSelectedMeasurement]))},
                           label: { Image(ContentViewImages.plusImage.rawValue)
                            .resizable()
                            .modifier(SaveButtonStyling())
                    })
                    .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                    .alert(isPresented: $showingAlert) { () -> Alert in
                        Alert(title: Text(stringStore.oneMoment),
                              message: Text(stringStore.makeSure),
                              dismissButton: .default(Text(ContentViewImages.thumbsUp.rawValue)))
                    }
                } // End of HStack
                .background(Color(BackgroundColours.defaultBackground.rawValue)
                    .edgesIgnoringSafeArea(.all))
            } /// End of VStack
            .padding(.top, Constants.topStackPadding.rawValue)
            .background(Color(BackgroundColours.defaultBackground.rawValue)
                .edgesIgnoringSafeArea(.all))
        } /// End of ZStack
        .edgesIgnoringSafeArea(.all)
        .background(Color(BackgroundColours.defaultBackground.rawValue)
            .edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    } /// End of body
} /// End of View


struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}
