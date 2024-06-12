import SwiftUI

private enum Constants: CGFloat {
    case fontSize = 16
    case height = 40
}

struct TypeHereStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: Constants.height.rawValue)
            .multilineTextAlignment(.leading)
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: Constants.fontSize.rawValue,
                          relativeTo: .headline))
            .ignoresSafeArea(.keyboard,
                             edges: .bottom)
    }
}

struct NotesOnItemStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: Constants.fontSize.rawValue,
                          relativeTo: .headline))
            .foregroundColor(.gray)
    }
}

struct ItemNameStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
    .frame (height: Constants.height.rawValue)
    .multilineTextAlignment(.leading)
    .font(.custom(DefaultFont.defaultFont.rawValue,
                  size: Constants.fontSize.rawValue,
                  relativeTo: .headline))
    }
}

struct ItemLimitStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: Constants.fontSize.rawValue,
                          relativeTo: .headline))
            .foregroundColor(.gray)
    }
}

struct ItemQuantityStyling: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame (height: Constants.height.rawValue)
            .multilineTextAlignment(.leading)
            .keyboardType(.decimalPad)
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: Constants.fontSize.rawValue,
                          relativeTo: .headline))
            .ignoresSafeArea(.keyboard,
                             edges: .bottom)
    }
}

struct ItemPickerStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: Constants.fontSize.rawValue,
                          relativeTo: .headline))
    }
}
