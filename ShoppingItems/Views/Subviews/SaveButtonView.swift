import Foundation
import SwiftUI

/// View that handles how the "+" button is displayed for the user
struct SaveButtonView: View {
    
    let frameWidth: CGFloat = 45
    let frameHeight: CGFloat = 45
    let bottomPadding: CGFloat = 28
    
    var body: some View{
        Image(ContentViewImages.plusImage.rawValue)
            .resizable()
            .frame(width: frameWidth,
                   height: frameHeight)
            .cornerRadius(.infinity)
            .padding(.bottom, bottomPadding)
    }
}
