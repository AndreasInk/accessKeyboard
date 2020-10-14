//
//  UserData.swift
//  Atilihy
//
//  Created by Andreas Ink on 7/26/20.
//  Copyright © 2020 Atilihy. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

final class UserData: ObservableObject {
    
    public static let shared = UserData()
    
    @Published(key: "firstRun")
    var firstRun: Bool = true
    
    @Published(key: "isOnboardingCompleted")
    var isOnboardingCompleted: Bool = false
    
    @Published(key: "name")
    var name: String = "nil"
    
    @Published(key: "userID")
    var userID: String = "nil"
    
    @Published
    var letter: String = ""
    
    @Published
    var string: String = "Type here"
    
    @Published
    var isKeyboardOpen: Bool = false
    
    @Published(key: "canRememberConvo")
    var canRememberConvo: Bool = false
    
     @Published(key: "canRememberTap")
    var canRememberTap: Bool = false
    
    @Published(key: "canRememberMotion")
   var canRememberMotion: Bool = false
    
     @Published
    var chat = [ChatData(id: "\(UUID())", name: "Bot_Name", message: "Hey, I'm Bot_Name! What's your name?", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: -1) ]
    
    @Published
    var step: Int = 0
    
    @Published
    var hasData: Bool = false
    
    @Published
    var demoKeyboards: Bool = false
    
    @Published
    var intentedWord: String = ""

    @Published
    var timeStamp: String = ""
    
    @Published
    var survey: Bool = false
}

import Foundation
import CryptoKit

extension UserDefaults {
    
    public struct Key {
        public static let lastFetchDate = "lastFetchDate"
    }
    
    @objc dynamic public var lastFetchDate: Date? {
        return object(forKey: Key.lastFetchDate) as? Date
    }
}

import Foundation
import Combine

extension Published {
    
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        projectedValue.receive(subscriber: Subscribers.Sink(receiveCompletion: { (_) in
            ()
        }, receiveValue: { (value) in
            UserDefaults.standard.set(value, forKey: key)
        }))
    }
    
}
