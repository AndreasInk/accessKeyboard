//
//  Keyboardv2App.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/3/20.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
       
        
        return true
    }
}
@main
struct Keyboardv2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var didTap1: Bool = false
    
    @State var didTap2: Bool = false
    var body: some Scene {
        WindowGroup {
          ContentView()
            .environmentObject(UserData.shared)
        }
    }
}
