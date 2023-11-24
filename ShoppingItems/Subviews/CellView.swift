import SwiftUI

/// This class deals with the cell creation that will be inserted into the stack in the ContentView class
struct CellView: View {
    
    //MARK: - Properties
    var itemToBeAdded: String = ""
    var quantitySelected: String = ""
    var preferredMeasurement: String = ""
    var multipleItems: String = "s"
    @State var finalOutput = ""
    @State var isChecked = false
    @State var moreThanOne = false
    let spacingVStack: CGFloat = 2
    let togglePadding: CGFloat = -8
    let minWidth: CGFloat = 300
    let idealWidth: CGFloat = 400
    let maxWidth: CGFloat = 450
    let minHeight: CGFloat = 80
    let idealHeight: CGFloat = 85
    let maxHeight: CGFloat = 95
    let itemFontSize: CGFloat = 24
    let noteFontSize: CGFloat = 18
    let stackPadding: CGFloat = 15
    let textColour: Color = Color.yellow
    let notesLineLimit: Int = 1
    let stringStore = StringStore()
    
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Toggle("", isOn: $isChecked)
                    .labelsHidden()
                    .padding(togglePadding)
                VStack (alignment: .leading, spacing: spacingVStack) {
                    /// Header: name of the item the user has selected
                    Text("\(itemToBeAdded)")
                        .font(.custom(DefaultFont.defaultFont.rawValue,
                                      size: itemFontSize,
                                      relativeTo: .title))
                        .allowsTightening(true)
                        .clipped()
                    /// Notes on the item that has been selected
                    Text("\(quantitySelected) \(preferredMeasurement)\(finalOutput)")
                        .font(.custom(DefaultFont.defaultFont.rawValue,
                                      size: noteFontSize,
                                      relativeTo: .title))
                        .lineLimit(notesLineLimit)
                        .textCase(.lowercase)
                } /// End of VStack
                .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
                .foregroundColor(textColour)
                .frame(minWidth: minWidth,
                       idealWidth: idealWidth,
                       maxWidth: maxWidth,
                       minHeight: minHeight,
                       idealHeight: idealHeight,
                       maxHeight: maxHeight,
                       alignment: .leading)
                .padding(stackPadding)
                .onAppear(perform: singleOrMultiple)
            }
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            .toggleStyle(CheckboxStyle())
        }
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
}
