//
//  ChatPermission.swift
//  Keyboard
//
//  Created by Andreas Ink on 7/30/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI
import CoreMotion
struct ChatPermission: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var title = ""
    
    @State var message = ""
    
    @State var action = ""
    
    @State var didTap1 = false
    
    @State var didTap2 = false
    
    let motionManager = CMMotionManager()
    var body: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
            VStack(alignment: .leading) {
                ScrollView {
                Text(title)
                    .font(.headline).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                }
                ScrollView {
                Text(message)
                    .font(.body).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                }
                
                HStack {
                    
                    Button(action: {
                        self.didTap1.toggle()
                        if self.action == "noti" {
                            
                            
                        } else if self.action == "Tap" {
                            self.userData.canRememberTap.toggle()
                        } else if self.action == "Convo" {
                            self.userData.canRememberConvo.toggle()
                        } else if self.action == "Motion" {
                           
                          
                        }
                        
                        
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Would it be alright if I remember where you tap within this app?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                            }
                            if self.userData.step == 2 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember this conversation so we can improve?", isMe: false, isView: true, viewMessage: "We do this to see how accurate you type.", viewTitle: "Allow ChatBot_Name to remember this conversation?", step: 2))
                            }
                            if self.userData.step == 3 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word: hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                        }
                    }) {
                        ZStack {
                            Color(didTap1 ? .systemBlue : .white)
                            Text("Yes")
                                .foregroundColor(didTap1 ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                    Button(action: {
                         self.didTap2.toggle()
                        self.userData.step =  self.userData.step + 1
                    }) {
                        ZStack {
                            Color(didTap2 ? .systemBlue : .white)
                            Text("No")
                                .foregroundColor(didTap2 ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                }
            }
        } .padding(12)
            .frame(height: 300)
    }
}

struct ChatPermission_Previews: PreviewProvider {
    static var previews: some View {
        ChatPermission()
    }
}
