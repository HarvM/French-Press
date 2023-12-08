import SwiftUI

/// This class deals with the cell creation that will be inserted into the stack in the ContentView class
struct CellView: View {

    //MARK: - Properties
    private enum CellConstraints {
        static let spacingVStack: CGFloat = 2
        static let togglePadding: CGFloat = -8
        static let minWidth: CGFloat = 300
        static let idealWidth: CGFloat = 400
        static let maxWidth: CGFloat = 450
        static let minHeight: CGFloat = 80
        static let idealHeight: CGFloat = 85
        static let maxHeight: CGFloat = 95
        static let stackPadding: CGFloat = 15
    }

    private enum TextDetails {
        static let itemFontSize: CGFloat = 24
        static let noteFontSize: CGFloat = 18
        static let notesLineLimit: Int = 1
        static let textColour: Color = Color.yellow
    }

    var preferredMeasurement: String = ""
    var multipleItems: String = "s"
    var quantitySelected: String = ""
    var itemToBeAdded: String = ""
    @State var finalOutput = ""
    @State var isChecked = false
    @State var moreThanOne = false
    let stringStore = StringStore()

    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Toggle("", isOn: $isChecked)
                    .labelsHidden()
                    .padding(CellConstraints.togglePadding)
                VStack (alignment: .leading, spacing: CellConstraints.spacingVStack) {
                    /// Header: name of the item the user has selected
                    Text("\(itemToBeAdded)")
                        .font(.custom(DefaultFont.defaultFont.rawValue,
                                      size: TextDetails.itemFontSize,
                                      relativeTo: .title))
                        .allowsTightening(true)
                        .clipped()
                    /// Notes on the item that has been selected
                    Text("\(quantitySelected) \(preferredMeasurement)\(finalOutput)")
                        .font(.custom(DefaultFont.defaultFont.rawValue,
                                      size: TextDetails.noteFontSize,
                                      relativeTo: .title))
                        .lineLimit(TextDetails.notesLineLimit)
                        .textCase(.lowercase)
                } /// End of VStack
                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                .foregroundColor(TextDetails.textColour)
                .frame(minWidth: CellConstraints.minWidth,
                       idealWidth: CellConstraints.idealWidth,
                       maxWidth: CellConstraints.maxWidth,
                       minHeight: CellConstraints.minHeight,
                       idealHeight: CellConstraints.idealHeight,
                       maxHeight: CellConstraints.maxHeight,
                       alignment: .leading)
                .padding(CellConstraints.stackPadding)
                .onAppear(perform: singleOrMultiple)
            }
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            .toggleStyle(CheckboxStyle())
        }
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
}
