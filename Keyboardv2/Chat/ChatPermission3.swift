//
//  ChatPermission3.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import CoreMotion

struct ChatPermission3: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var title = ""
    
    @State var message = ""
    
    @State var action = ""
    
   
    @Binding var isKeyboardOpen: Bool
   
    let motionManager = CMMotionManager()
   
    @Binding var didTap1: Bool
    @Binding var didTap2: Bool
    
    @State var one = false
    @State var two = false
    @Binding var demo: Bool
    @Binding var chat: [ChatData]
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
                        one.toggle()
                        self.userData.step += 1
                        print(self.userData.step )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                               chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember your acceleration data within the app?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                                
                               
                            }
                         
                            if self.userData.step == 2 {
                               chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word: hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                        }
                        if self.action == "noti" {
                            
                            
                        } else if self.action == "Tap" {
                         
                           
                        } else if self.action == "Convo" {
                           
                            
                        } else if self.action == "Motion" {
                           
                          
                        }
                        if chat.last?.viewTitle == "Try out demo keyboards?" {
                           demo = true
                            chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                            self.userData.intentedWord = "hello"
                        }
                        if chat.last?.viewTitle == "Take a survey to help us build a helpful keyboard?" {
                            userData.survey = true
                        }
                    }) {
                        ZStack {
                            Color(one  ? .systemPink : .white)
                            Text("Yes")
                                .foregroundColor(one  ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                    Button(action: {
                      //  userData.demoKeyboards = false
                        isKeyboardOpen = false
                        two.toggle()
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                       chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Thank you for helping us make a difference!", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 1))
                        }
                    }) {
                        ZStack {
                            Color( two ? .systemPink : .white)
                            Text("No")
                                .foregroundColor(two ? .white : .black)
                                .fontWeight(.bold)
                            
                           
                        }
                    } .frame(height: 50)
                }
            }
        } .padding(12)
            
    }
}

