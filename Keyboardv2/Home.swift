//
//  Home.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/7/20.
//

import SwiftUI
import Firebase

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
    @State var step: Int = 0
    @State var keysMistyped = [Double]()
    @State var keysMistyped2 = [String]()
    @State var intentedKeys = [String]()
    @State var keyNum: Int = 0
    @State var keyNum2: Int = 0
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
                   
            }
           
            VStack {
              
                ChatView(x: $x, y: $y, z: $z, keyTime: $keyTime, isKeyboardOpen: $isKeyboardOpen)
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
                    .onTapGesture {
                       isKeyboardOpen.toggle()
                        if text == "Type Here" {
                       text = ""
                        } else {
                            text = "Type Here"
                        }
                   }
                    ZStack {
                        Ellipse()
                            .foregroundColor(.blue)
                            .frame(width: 75, height: 75)
                        
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.bold)
                           
                    }  .onTapGesture {
                        
                        
                  
                        userData.chat.append(ChatData(id: "\(UUID())", name: self.userData.name, message:  text, isMe: true, isView: false, viewMessage: "", viewTitle: "", step: step))
                      
                        let keys = Array(text)
                        print(userData.intentedWord)
                        intentedKeys = Array(arrayLiteral: userData.intentedWord)
                        for key in keys {
                           
                            //print(iKey)
                            print(keyNum2)
                    
                          //  if keyNum == keyNum2 {
                            if userData.intentedWord != "" {
                                let index = userData.intentedWord.index(userData.intentedWord.startIndex, offsetBy: keyNum2)
                                
                                if "\(key)" != String(userData.intentedWord[index]) {
                            
                            keysMistyped.append(0.5)
                           print("mistype")
                        
                        
                            }
                                keyNum2 += 1
                                if keyNum2 >= userData.intentedWord.count {
                                    keyNum2 = 0
                                }
                        }
                            
                        }
                        
                        
                       
                                let db = Firestore.firestore()

                        db.collection("interactions").document(UUID().uuidString).setData(["id": UUID().uuidString, "x": x, "y": y, "z": z, "keysMistyped": keysMistyped, "time": time, "type": "Reg", "keysMistyped2": keysMistyped2])
                                
                              
                                            
                            
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                isKeyboardOpen = false
                               // self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "", isMe: false, isView: true, viewMessage: "keys: \(keys) " + "new \(timeNew) " + "reg \(timeReg) ", viewTitle: " x: \(x) " + "y: \(y) " + "z: \(z) ", step: 2))
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Would it be alright if I remember where you tap?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember where you've tapped?", step: 1))
                                
                            }
                            if self.userData.step == 2 {
                               
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember this conversation so we can improve?", isMe: false, isView: true, viewMessage: "We do this to see how accurate you type.", viewTitle: "Allow ChatBot_Name to remember this conversation?", step: 2))
                            }
                            if self.userData.step == 3 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                            if self.userData.step == 4 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  Where are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 4))
                                self.userData.intentedWord = "Where are you"
                            }
                            if self.userData.step == 5 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  I will be there in 10 mins", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 5))
                                self.userData.intentedWord = "I will be there in 10 mins"
                            }
                            if self.userData.step == 6 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  How are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "How are you"
                            }
                            if self.userData.step == 6 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  Thanks", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "Thanks"
                            }
                        }
                        if isKeyboardOpen {
                       text = ""
                        } else {
                            text = "Type Here"
                        }
                
                }
                }
            if isKeyboardOpen {
                VStack {
               // Spacer(minLength: screenSize.height/2.5)
                    MotionView(x: $x, y:$y, z:$z, text: $text, isKeyboardOpen: $isKeyboardOpen, keyNum: $keyNum, keyNum2: $keyNum2)
                    .ignoresSafeArea()
                }
            
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
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
