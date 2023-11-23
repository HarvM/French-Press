import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct YerMessagesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ShoppingItems.self)
        }
    }
}

//#Preview {
//    YerMessagesApp()
//}
