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
    
    let motionManager = CMMotionManager()
    @State var didTap1: Bool = false
    
    @State var didTap2: Bool = false
    var body: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
            VStack(alignment: .leading) {
             
                Text(title)
                    .font(.headline).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
              
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                HStack {
                    
                    Button(action: {
                       
                     
                        self.userData.canRememberMotion = true
                        self.userData.canRememberConvo = true
                        didTap1.toggle()
                        self.userData.step += 1
                        print(self.userData.step )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember your acceleration data within the app?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                                
                               
                            }
                         
                            if self.userData.step == 2 {
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
                        }
                        if userData.chat.last?.viewTitle == "Take a survey to help us build a helpful keyboard?" {
                            userData.survey = true
                        }
                    }) {
                        ZStack {
                            Color(didTap1  ? .systemPink : .white)
                            Text("Yes")
                                .foregroundColor(didTap1  ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                    Button(action: {
                        userData.demoKeyboards = false
                        isKeyboardOpen = false
                        didTap2.toggle()
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Thank you for helping us make a difference!", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 1))
                        }
                    }) {
                        ZStack {
                            Color( didTap2 ? .systemPink : .white)
                            Text("No")
                                .foregroundColor(didTap2 ? .white : .black)
                                .fontWeight(.bold)
                            
                           
                        }
                    } .frame(height: 50)
                }
            }
        } .padding(12)
            
    }
}

