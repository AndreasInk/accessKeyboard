//
//  Keyboardv2App.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/3/20.
//

import SwiftUI

@main
struct Keyboardv2App: App {
    var body: some Scene {
        WindowGroup {
            MotionView2()
                .environmentObject(UserData.shared)
        }
    }
}
