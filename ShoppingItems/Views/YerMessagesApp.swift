import SwiftUI
import SwiftData

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
