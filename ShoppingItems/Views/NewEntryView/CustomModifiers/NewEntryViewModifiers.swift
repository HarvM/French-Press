import SwiftUI

private enum NewEntryViewConstants: CGFloat {
    case leadingPadding = -10
    case saveButtonWidthOrHeight = 45
    case saveButtonBottomPadding = 28
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .truncationMode(.head)
            .padding(.leading, NewEntryViewConstants.leadingPadding.rawValue)
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
}

struct FormModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipped()
            .padding(.top)
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            .modifier(AdaptsToKeyboard())
            .scrollContentBackground(.hidden)
    }
}

struct SaveButtonStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: NewEntryViewConstants.saveButtonWidthOrHeight.rawValue,
                   height: NewEntryViewConstants.saveButtonWidthOrHeight.rawValue)
            .cornerRadius(.infinity)
            .overlay(Circle()
                .inset(by: 5)
                .stroke(Color.black, lineWidth: 5)
                .frame(width: NewEntryViewConstants.saveButtonWidthOrHeight.rawValue,
                       height: NewEntryViewConstants.saveButtonWidthOrHeight.rawValue)
                .rainbowAnimation())
            .padding(.bottom, NewEntryViewConstants.saveButtonBottomPadding.rawValue)
    }
}
