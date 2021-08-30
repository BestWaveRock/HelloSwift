//
//  HelloSwiftApp.swift
//  HelloSwift
//
//  Created by 梁家新 on 2021/8/27.
//

import SwiftUI

@main
struct HelloSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
        }
    }
}

struct HelloSwiftApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, Swift!")
//        Button("PLAY Game👋", action: something)
    }
}
