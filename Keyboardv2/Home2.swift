//
//  Home2.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import Firebase
struct Home2: View {
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
    @State var time = 0.0
    
    @State var timeNew = 0.0
    @State var timeReg = 0.0
    @EnvironmentObject var userData: UserData
    @State var step: Int = 0
    @State var keysMistyped = [Double]()
    @State var keysMistyped2 = [String]()
    @State var intentedKeys = [String]()
    @State var keyNum: Int = 0
    @State var keyNum2: Int = 0
    @State var wait: Bool = true
    
    @Binding var didTap1: Bool
    
    @Binding var didTap2: Bool
    
    @State var timeOn: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
           
                .onTapGesture {
                    isKeyboardOpen = false
                    text = "Type Here"
                    let defaults = UserDefaults.standard
                     timeNew = defaults.double(forKey: "timeNew")
                     timeReg = defaults.double(forKey: "timeReg")
                }
                .onAppear() {
                    self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                    self.userData.intentedWord = "hello"
                    self.userData.step = 9
            }
           
            VStack {
              
                ChatView(x: $x, y: $y, z: $z, keyTime: $keyTime, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap1, text: $text)
                    .zIndex(1)
                        .onTapGesture {
                            isKeyboardOpen = false
                           
                        }
              Spacer()
                Divider()
                HStack {
                    ZStack {
                        Color(.white)
                            .frame(width: screenSize.width/1.4, height: 120, alignment: .leading)
                        
                        
                Text(text)
                    
                    .font(.headline)
                    .frame(width: screenSize.width/1.4, height: 120, alignment: .leading)
                                        
                   } .onTapGesture {
                    isKeyboardOpen.toggle()
                     if text == "Type Here" {
                    text = ""
                     } else {
                         text = "Type Here"
                     }
                 }
                    ZStack {
                        Ellipse()
                            .foregroundColor(Color(.systemPink))
                            .frame(width: 75, height: 75)
                        
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                           
                    }  .onTapGesture {
                        timeOn = false
                        if text != "" {
                        if text != "Type Here" {
                        userData.chat.append(ChatData(id: "\(UUID())", name: self.userData.name, message:  text, isMe: true, isView: false, viewMessage: "", viewTitle: "", step: step))
                        }
                        }
                        
                        let db = Firestore.firestore()
                       
                        if userData.canRememberConvo {

                                
                            let keys = Array(text)
                            print(userData.intentedWord)
                            intentedKeys = Array(arrayLiteral: userData.intentedWord)
                            for key in keys {
                               
                                //print(iKey)
                                print(keyNum2)
                        
                              //  if keyNum == keyNum2 {
                                if keyNum2 >= userData.intentedWord.count {
                                    keyNum2 = 0
                                }
                                if userData.intentedWord != "" {
                                    let index = userData.intentedWord.index(userData.intentedWord.startIndex, offsetBy: keyNum2)
                                    
                                    if "\(key)" != String(userData.intentedWord[index]) {
                                
                                keysMistyped.append(0.5)
                                        keysMistyped2.append("\(String(userData.intentedWord[index]))")
                               print("mistype")
                            
                            
                                }
                                    keyNum2 += 1
                                    
                            }
                                
                            }
                        }
                    
                            if userData.canRememberConvo {
                        db.collection("interactions").document(UUID().uuidString).setData(["id": UUID().uuidString, "x": x, "y": y, "z": z, "keysMistyped": keysMistyped, "time": time, "type": "Zoom", "keysMistyped2": keysMistyped2])
                                time = 0.0
                                x.removeAll()
                                y.removeAll()
                                z.removeAll()
                                intentedKeys.removeAll()
                                keysMistyped.removeAll()
                                keysMistyped2.removeAll()
                                keys.removeAll()
                                keyTime.removeAll()
                            }
                                            
                        
                       
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 9 {
                               
                                
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  where are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 4))
                                self.userData.intentedWord = "where are you"
                               
                            }
                          
                            if self.userData.step == 10 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  how are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "how are you"
                         
                            }
                            if self.userData.step == 11 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  thanks", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "thanks"
                               
                            }
                            if self.userData.step == 12 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "What apps do you use most frequently?", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = ""
                              
                            }
                            if self.userData.step == 13 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "What issues do you face when you type?", isMe: false, isView: false, viewMessage: "", viewTitle: "Take a survey to help us build a helpful keyboard?", step: 6))
                               
                                db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What apps do you use most frequently?" : self.text])
                               
                            }
                            if self.userData.step == 14 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "What specific keys do you have trouble tapping?", isMe: false, isView: false, viewMessage: "What specific keys do you have trouble tapping?", viewTitle: "Take a survey to help us build a helpful keyboard?", step: 6))
                                
                                db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What issues do you face when you type?" : self.text])
                            }
                            if self.userData.step == 15 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "How can we make your keyboard optimized to you?", isMe: false, isView: false, viewMessage: "", viewTitle: "Take a survey to help us build a helpful keyboard?", step: 6))
                                db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What specific keys do you have trouble tapping?" : self.text])
                                
                               
                            }
                            if self.userData.step == 16 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Take an additional survey to help us build a helpful keyboard?", isMe: false, isView: true, viewMessage: "", viewTitle: "Take a survey to help us build a helpful keyboard?", step: 6))
                                db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "How can we make your keyboard optimized to you?" : self.text])
                                isKeyboardOpen = false
                            }
                          
                        }
                        
                        
                            if text != "" {
                            if text != "Type Here" {
                            self.userData.step =  self.userData.step + 1
                            }
                            }
                       
                }
                        
                    }
                    
                    
                    
            if isKeyboardOpen {
               
                   
                VStack {
               // Spacer(minLength: screenSize.height/2.5)
                    MotionView2(x: $x, y:$y, z:$z, text: $text, isKeyboardOpen: $isKeyboardOpen, keyNum: $keyNum, keyNum2: $keyNum2, keysMistyped: $keysMistyped, wait: $wait, time: $time, timeOn: $timeOn)
                        .environmentObject(UserData.shared)
                    .ignoresSafeArea()
                }
            
            }
               
            }
            }
         
        
           
        }
    }