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
    
   
    @Binding var isKeyboardOpen: Bool
    @Binding var didTap1: Bool
    
    @Binding var didTap2: Bool
    @Binding var text: String
    let motionManager = CMMotionManager()
    var body: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
            VStack(alignment: .leading) {
             
                Text(title)
                    .font(.headline).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
              
                Text(message)
                    .font(.body).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                
                HStack {
                    
                    Button(action: {
                       
                     
                        text = "Type Here"
                        self.userData.canRememberConvo = true
                        self.userData.step += 1
                        print(self.userData.step )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember your acceleration data within the app?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                                
                                
                               
                            }
                            if self.userData.step == 2 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember this conversation so we can improve?", isMe: false, isView: true, viewMessage: "We do this to see how accurate you type.", viewTitle: "Allow ChatBot_Name to remember this conversation?", step: 2))
                                
                            }
                            if self.userData.step == 3 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word: hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                        }
                        if self.action == "noti" {
                            
                            
                        } else if self.action == "Tap" {
                         
                           
                        } else if self.action == "Convo" {
                           
                            
                        } else if self.action == "Motion" {
                           
                          
                        }
                        if userData.chat.last?.viewTitle == "Try out demo keyboards?" {
                            userData.demoKeyboards = true
                            isKeyboardOpen = false
                            text = "Type Here"
                        }
                    }) {
                        ZStack {
                            Color(userData.canRememberConvo ? .systemPink : .white)
                            Text("Yes")
                                .foregroundColor(userData.canRememberConvo ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                    Button(action: {
                        userData.canRememberConvo = false
                        isKeyboardOpen = false
                    text = "Type Here"
                        self.userData.step =  self.userData.step + 1
                    }) {
                        ZStack {
                            Color( userData.canRememberConvo ? .white : .systemPink)
                            Text("No")
                                .foregroundColor( userData.canRememberConvo ? .black : .white)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                }
            }
        } .padding(12)
            .frame(height: 300)
    }
}

