import SwiftUI

struct ThemesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    private var themeNames = ["Bobcat", "Stratos", "Enigma", "Belter"]
    private var themeDetails = ["Fun", "Cool", "Something else", "Hello there"]
    private var oneColumnGrid = [GridItem(.flexible())]
    private var imagesForGrid = [ContentViewImages.appIcon.rawValue, ContentViewImages.appIcon.rawValue, ContentViewImages.appIcon.rawValue, ContentViewImages.appIcon.rawValue]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            LazyVGrid(columns: oneColumnGrid) {
                                ForEach((0...3), id: \.self) {
                                    /// Theme Name
                                    Text("Theme name: \(themeNames[$0 % themeNames.count])")
                                        .font(.callout)
                                    /// Extra Info
                                    Text("Extra information: \(themeDetails[$0 % themeDetails.count])")
                                        .font(.footnote)
                                    /// Image of the theme (placeholder for now)
                                    Image("\(imagesForGrid[$0 % imagesForGrid.count])")
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Button(action: self.buyNewTheme, label: {
                                        Text("Purchase New Theme")
                                            .font(.footnote)
                                    })
                                }
                                /// Sorts the frame of all of the LazyVGrid
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height/9,
                                       alignment: .center)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
            .navigationBarTitle("Themes")
            .foregroundColor(.yellow)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ThemesView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesView()
    }
}
