//
//  Photo_WidgetApp.swift
//  Photo Widget
//
//  Created by muhammed on 29/09/2020.
//

import SwiftUI

@main
struct Photo_WidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImageManager())
        }
    }
}
