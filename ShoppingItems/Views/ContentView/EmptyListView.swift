//
//  EmptyListView.swift
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
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }

                // MARK: - NavigationBarItems: Leading item will be the HamburgerMenu button that lets the user access the settings, the trailing item: let's the user add a new item to the CoreData/list
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment:.center)
                            .edgesIgnoringSafeArea(.all)
                        ){
                            Image(ContentViewImages.plusImage.rawValue)
                                .frame(width: 35, height: 35)
                                .cornerRadius(.infinity)
                        }
                    }
                } /// End of toolbar
                .foregroundColor(.white)
                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
            } /// End of ZStack
            .popover(isPresented: $something) {
                UserInstructionsView()
                    .presentationDetents([.medium])
            }
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    EmptyListView()
}
