import SwiftUI

struct DetailItemAddedStyling: ViewModifier {
    private let fontSizeItemToBeDisplayed: CGFloat = 35
    private let lineLimit: Int =  3
    private let foregroundColourYellow: Color = Color.yellow

    func body(content: Content) -> some View {
        content
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: fontSizeItemToBeDisplayed,
                          relativeTo: .headline))
            .lineLimit(lineLimit)
            .foregroundColor(foregroundColourYellow)
    }
}


struct DetailItemNotesStyling: ViewModifier {
    private let fontSizeNotes: CGFloat = 35
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: fontSizeNotes,
                          relativeTo: .headline))
    }
}

struct DetailViewNavigationStyling: ViewModifier {
    private let maximumScaleFactor: Double = 0.9

    func body(content: Content) -> some View {
        content
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            .multilineTextAlignment(.center)
            .allowsTightening(true)
            .minimumScaleFactor(maximumScaleFactor)
            .navigationViewStyle(StackNavigationViewStyle())  /// removes iPad split screen
    }
}
