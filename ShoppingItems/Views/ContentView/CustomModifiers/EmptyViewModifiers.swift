import SwiftUI

private enum EmptyListConstant: CGFloat {
    case plusButtonHeightOrWidth = 35
}

struct EmptyListStlying: ViewModifier {
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

struct PlusButtonEmptyViewStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: EmptyListConstant.plusButtonHeightOrWidth.rawValue,
                   height: EmptyListConstant.plusButtonHeightOrWidth.rawValue)
            .cornerRadius(.infinity)
    }
}
