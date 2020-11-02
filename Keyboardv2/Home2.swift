//
//  Home2.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import Firebase
import FirebaseStorage

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
    
    @State  var taskArr = [Task]()
    @State  var task: Task!
    @State var i: Int = 0
    
    @State var counter = 0
    @Binding var demo: Bool
    @State var chat = [ChatData(id: "\(UUID())", name: "Bot_Name", message: "Hey, I'm Bot_Name! What's your name?", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: -1) ]
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
           
                .onTapGesture {
                    time = 0.0
                    isKeyboardOpen = false
                    text = "Type Here"
                    
                }
                .onAppear() {
                    self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                    self.userData.intentedWord = "hello"
                    self.userData.step = 9
            }
           
            VStack {
              
                ChatView(x: $x, y: $y, z: $z, keyTime: $keyTime, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap1, text: $text, demo: $demo, chat: $chat)
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
                    text = " "
                     } else {
                         text = "Type Here"
                     }
                 }
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.systemPink))
                            .frame(width: screenSize.width/7)
                        Image(systemName: "arrow.up")
                            .foregroundColor(Color(.white))
                            .font(.headline)
                           
                           
                    }  .onTapGesture {
                        timeOn = false
                        
                        if text != " " {
                        if text != "Type Here" {
                           
                        chat.append(ChatData(id: "\(UUID())", name: self.userData.name, message:  text, isMe: true, isView: false, viewMessage: "", viewTitle: "", step: step))
                        }
                        }
                        
                        let db = Firestore.firestore()
                       
                        if  self.userData.step == 0 {
                            userData.step = 9
                        }
                    
                            if userData.canRememberConvo {
                      //  db.collection("interactions").document(UUID().uuidString).setData(["id": UUID().uuidString, "x": x, "y": y, "z": z, "keysMistyped": keysMistyped, "time": time, "type": "Zoom", "keysMistyped2": keysMistyped2])
                                shareButton2()
                                if self.userData.step == 12 {
                                   
                                   
                                    db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What apps do you use most frequently?" : self.text])
                                   
                                }
                                if self.userData.step == 14 {
                                   
                                    
                                    db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What issues do you face when you type?" : self.text])
                                }
                                if self.userData.step == 14 {
                                    
                                    db.collection("surveyData").document(UUID().uuidString).setData(["id": UUID().uuidString, "What specific keys do you have trouble tapping?" : self.text])
                                    
                                   
                                }
                                time = 0.0
                                keyNum = 0
                                keyNum2 = 0
                                counter = 0
                                x.removeAll()
                                y.removeAll()
                                z.removeAll()
                                intentedKeys.removeAll()
                                keysMistyped.removeAll()
                                keysMistyped2.removeAll()
                                keyTime.removeAll()
                                keys.removeAll()
                                
                            } else {
                                time = 0.0
                                keyNum = 0
                                keyNum2 = 0
                                counter = 0
                                x.removeAll()
                                y.removeAll()
                                z.removeAll()
                                intentedKeys.removeAll()
                                keysMistyped.removeAll()
                                keysMistyped2.removeAll()
                                keyTime.removeAll()
                                keys.removeAll()
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
                                self.userData.intentedWord = " "
                              
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
                        
                        
                            if text != " " {
                            if text != "Type Here" {
                            self.userData.step =  self.userData.step + 1
                            }
                            }
                       
                }
                        
                    }
                    
                    
                .frame(width: screenSize.width, height: screenSize.height/7, alignment: .center)
            if isKeyboardOpen {
               
                   
                VStack {
               // Spacer(minLength: screenSize.height/2.5)
                    MotionView2(x: $x, y:$y, z:$z, text: $text, isKeyboardOpen: $isKeyboardOpen, keyNum: $keyNum, keyNum2: $keyNum2, keysMistyped: $keysMistyped, wait: $wait, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, counter: $counter)
                        .environmentObject(UserData.shared)
                    .ignoresSafeArea()
                }
            
            }
               
            }
            }
         
        
           
        }
    func shareButton2() {
           let fileName = "testing.csv"
           let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
           var csvText = "Int,Type\n"

           for task in taskArr {
            let newLine = "\(task.keysMistyped)\(task.x)\n"
            csvText.append(newLine)
           
         //   csvText.append( "\(task.y)\n")
          //  csvText.append( "\(task.z)\n")
           }
        var mailString = NSMutableString()
        mailString.append("Mistypes, X, Y, Z, Keys\n")
        i = 0
        if text.isEmpty {
            
        } else {
        for n in 0...counter - 1 {
        mailString.append("\(keysMistyped[n]),\(x[n]),\(y[n]),\(z[n]),\(keysMistyped2)\n")
            i += 1
        }
        // Converting it to NSData.
        }
        
           do {
            try mailString.write(to: path!, atomically: true, encoding: String.Encoding.utf8.rawValue)
           } catch {
               print("Failed to create file")
               print("\(error)")
           }
           print(path ?? "not found")

           var filesToShare = [Any]()
           filesToShare.append(path!)

       
        let data = mailString.data(using: String.Encoding.utf8.rawValue)!
        let storageRef = Storage.storage().reference()
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("Hybrid-\(userData.intentedWord)-\(UUID()).csv")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
          print(error)
            return
          }
       }
    }
    }
