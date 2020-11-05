//
//  ContentView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var zoomed: Bool = false
    @State var isKeyboardOpen: Bool = false
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
    @State var text: String = "Type Here"
    @State var key: String = ""
    @State var x = [Double]()
    
    @State var y = [Double]()
    
    @State var z = [Double]()
    
    @State var keys = [String]()
    @State var keyTime = [Double]()
    @State var time = [String]()
    
    @State var timeNew = 0.0
    @State var timeReg = 0.0
    @State var step: Int = 0
    @State var keysMistyped = [Double]()
    @State var keysMistyped2 = [String]()
    @State var intentedKeys = [String]()
    @State var keyNum: Int = 0
    @State var keyNum2: Int = 0
    
    @State var didTap1: Bool = false
    
    @State var didTap2: Bool = false
    
    @State var demo: Bool = false
    @State var chat = [ChatData(id: "\(UUID())", name: "Bot_Name", message: "Hey, I'm Bot_Name! What's your name?", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: -1) ]
    var body: some View {
        ZStack {
        if userData.isOnboardingCompleted {
           
                Home(didTap1: $didTap1, didTap2: $didTap2, demo: $demo, chat: $chat)
                .environmentObject(UserData.shared)
                    .onDisappear() {
                        keyNum = 0
                        keyNum2 = 0
                        x.removeAll()
                        y.removeAll()
                        z.removeAll()
                        intentedKeys.removeAll()
                        keysMistyped.removeAll()
                        keysMistyped2.removeAll()
                        keyTime.removeAll()
                        
                    }
                  
         
        } else {
        Onboarding()
            .environmentObject(UserData.shared)
    }
            if userData.survey {
           Survey()
    }
    }
}

}
