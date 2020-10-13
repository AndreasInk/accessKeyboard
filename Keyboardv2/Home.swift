//
//  Home.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/7/20.
//

import SwiftUI

struct Home: View {
    let screenSize = UIScreen.main.bounds
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
    @EnvironmentObject var userData: UserData
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
           
                .onTapGesture {
                    isKeyboardOpen = false
                    let defaults = UserDefaults.standard
                     timeNew = defaults.double(forKey: "timeNew")
                     timeReg = defaults.double(forKey: "timeReg")
                }
                .onAppear() {
                   
            }
           
            VStack {
              
                ChatView(x: $x, y: $y, z: $z, keyTime: $keyTime)
                    .zIndex(1)
                        .onTapGesture {
                            isKeyboardOpen = false
                        }
              Spacer()
                Divider()
                HStack {
                Text(text)
                    
                    .font(.headline)
                    .padding()
                    .frame(width: screenSize.width/1.5, alignment: .leading)
                    ZStack {
                        Ellipse()
                            .foregroundColor(.blue)
                            .frame(width: 75, height: 75)
                        
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                           
                    }  .onTapGesture {
                        
                        
                  
                        userData.chat.append(ChatData(id: "\(UUID())", name: self.userData.name, message:  text, isMe: true, isView: false, viewMessage: "", viewTitle: "", step: 0))
                        
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "", isMe: false, isView: true, viewMessage: "keys: \(keys) " + "new \(timeNew) " + "reg \(timeReg) ", viewTitle: " x: \(x) " + "y: \(y) " + "z: \(z) ", step: 2))
                               // self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Would it be alright if I remember where you tap?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                                
                            }
                            if self.userData.step == 2 {
                               
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember this conversation so we can improve?", isMe: false, isView: true, viewMessage: "We do this to see how accurate you type.", viewTitle: "Allow ChatBot_Name to remember this conversation?", step: 2))
                            }
                            if self.userData.step == 3 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                            if self.userData.step == 4 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                            if self.userData.step == 5 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                            if self.userData.step == 6 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                        }
                        text = "Type Here"
                }
                } .onTapGesture {
                    isKeyboardOpen.toggle()
                }
            if isKeyboardOpen {
               
             
                ContentView(zoomed: $zoomed, text: $text, key: $key, x: $x, y: $y, z: $z, keysTime: $keyTime,  keys: $keys, isKeyboardOpen: $isKeyboardOpen)
                    .ignoresSafeArea()
                
            
            }
            }
         
        }
           
        }
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
