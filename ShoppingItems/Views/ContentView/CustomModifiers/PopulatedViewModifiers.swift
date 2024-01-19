import SwiftUI

private enum PopulatedViewConstants: CGFloat {
    case leadingPadding = 20
    case buttonWidthOrHeight = 35
    case buttonCornerRadius = 38.5
}

struct ToolbarStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,
                   idealWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   idealHeight: 0,
                   maxHeight: .infinity,
                   alignment:.center)
            .edgesIgnoringSafeArea(.all)
    }
}

struct SectionStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(alignment: .leading)
            .listStyle(PlainListStyle())
            .listRowBackground(Color(BackgroundColours.defaultBackground.rawValue)
                .edgesIgnoringSafeArea(.all))
    }
}

struct ListStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top)
            .padding(.leading, PopulatedViewConstants.leadingPadding.rawValue)
            .listRowSeparator(.hidden)
    }
}

struct PlusButtonStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: PopulatedViewConstants.buttonWidthOrHeight.rawValue,
                   height: PopulatedViewConstants.buttonWidthOrHeight.rawValue)
            .cornerRadius(PopulatedViewConstants.buttonCornerRadius.rawValue)
    }
}

