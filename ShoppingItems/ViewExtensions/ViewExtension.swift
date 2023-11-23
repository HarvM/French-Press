import Foundation
import SwiftUI

/// Extension on the View and all views that ensures that the Editing on the ContentView is ended correctly
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
