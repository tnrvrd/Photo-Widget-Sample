//
//  ContentView.swift
//  Photo Widget
//
//  Created by muhammed on 29/09/2020.
//

import SwiftUI

extension UIScreen{
    static let imageBoxSize = UIScreen.main.bounds.size.width / CGFloat(twoColumnsGrid.count) - 10
}

private var twoColumnsGrid = [GridItem(.flexible()), GridItem(.flexible())]

struct ContentView: View {
    
    @EnvironmentObject var imageManager: ImageManager
    
    @State private var showImagePicker = false
    @State private var image = UIImage()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: twoColumnsGrid) {
                    ForEach(imageManager.photos, id: \.self) { photo in
                        
                        Image(uiImage: Helper.getImageFromUserDefaults(key: photo))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.imageBoxSize, height: UIScreen.imageBoxSize)
                            .cornerRadius(10)
                    }
                }
            }
            
            
            Button(action: {
                self.showImagePicker.toggle()
            }) {
                Text("Add Photo")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
            }
            .sheet(isPresented: $showImagePicker , content: {
                ImagePicker(selectedImage: self.$image)
            })
            .onChange(of: image) { _ in
                imageManager.appendImage(image: image)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImageManager())
    }
}
