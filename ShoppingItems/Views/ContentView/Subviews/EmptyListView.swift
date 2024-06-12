import SwiftUI

struct EmptyListView: View {
    @State var something: Bool = true
    let stringStore = StringStore()

    // MARK: - EmptyListView - used upon initial launch and should the user have no items
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        Image(ContentViewImages.appIcon.rawValue)
                            .padding(.top, geometry.size.height/2)
                        Spacer()
                    } /// End of VStack
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .center)
                }

                // MARK: - NavigationBarItems:
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .modifier(EmptyListStyling())
                        ){
                            Image(ContentViewImages.plusImage.rawValue)
                                .modifier(PlusButtonEmptyViewStyling())
                        }
                    }
                } /// End of toolbar
            } /// End of ZStack
            /// Alter this later to be a modal popup
            //            .fullScreenCover(isPresented: $something) {
            //                UserInstructionsView()
            //            }
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    EmptyListView()
}
