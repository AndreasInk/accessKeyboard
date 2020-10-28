//
//  Home3.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/27/20.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct Home3: View {
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
    @State var keyNum: Int = -1
    @State var keyNum2: Int = -1
    
    @Binding var didTap1: Bool
    
    @Binding var didTap2: Bool
    
    @State var timeOn: Bool = false
    
    @State  var taskArr = [Task]()
    @State  var task: Task!
    @State var i: Int = 0
    @State private var isShareSheetShowing = false
   // @Environment(\.exportFiles) var exportAction
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
           
                .onTapGesture {
                    isKeyboardOpen = false
                    text = "Type Here"
                   
                }
                .onAppear() {
                   
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
                    text = " "
                     } else {
                         text = "Type Here"
                     }
                 }
                    ZStack {
                        Ellipse()
                            .foregroundColor(Color(.systemPink))
                            .frame(width: 100, height: 100)
                        
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.headline)
                            
                           
                    }  .onTapGesture {
                        timeOn = false
                        
                        if text != " " {
                        if text != "Type Here" {
                        userData.chat.append(ChatData(id: "\(UUID())", name: self.userData.name, message:  text, isMe: true, isView: false, viewMessage: "", viewTitle: "", step: step))
                        }
                        }
                        let keys = Array(text)
                        print(userData.intentedWord)
                     
                     
                        
                        
                        if userData.canRememberConvo {
                            if userData.step > 0 {
                                let db = Firestore.firestore()

                        db.collection("interactions").document(UUID().uuidString).setData(["id": UUID().uuidString, "x": x, "y": y, "z": z, "keysMistyped": keysMistyped, "time": time, "type": "Reg", "keysMistyped2": keysMistyped2])
                                task = Task()
                                for  x in x {
                                    task.keysMistyped = keysMistyped[i]
                                    task.x = x
                                    task.y = y[i]
                                    task.z = z[i]
                                    taskArr.append(task!)
                                    
                                   
                                }

                                shareButton2()
                            
                            time = 0.0
                            keyNum = 0
                            keyNum2 = 0
                            x.removeAll()
                            y.removeAll()
                            z.removeAll()
                            intentedKeys.removeAll()
                            keysMistyped.removeAll()
                            keysMistyped2.removeAll()
                            keyTime.removeAll()
                        
                        } else {
                            time = 0.0
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
                            time = 0.0
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
                        if text != " " {
                        if text != "Type Here" {
                        self.userData.step =  self.userData.step + 1
                        }
                        }
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if self.userData.step == 1 {
                                isKeyboardOpen = false
                               // self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "", isMe: false, isView: true, viewMessage: "keys: \(keys) " + "new \(timeNew) " + "reg \(timeReg) ", viewTitle: " x: \(x) " + "y: \(y) " + "z: \(z) ", step: 2))
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can I remember your acceleration data and remember our conversation within this app?", isMe: false, isView: true, viewMessage: "We do this to determine mistaps and analyze any patterns that arise so we can help you type more accurately.", viewTitle: "Allow ChatBot_Name to remember your acceleration data and this conversation?", step: 1))
                                
                            }
                           
                            if self.userData.step == 2 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this word:  hello", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 3))
                                self.userData.intentedWord = "hello"
                            }
                            if self.userData.step == 3 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  where are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 4))
                                self.userData.intentedWord = "where are you"
                            }
                            if self.userData.step == 4 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  how are you", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "how are you"
                            }
                            if self.userData.step == 5 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  thanks", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 6))
                                self.userData.intentedWord = "thanks"
                               
                            }
                            if self.userData.step == 6 {
                                self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Can you please type this:  thanks", isMe: false, isView: true, viewMessage: "", viewTitle: "Try out demo keyboards?", step: 6))
                                self.userData.intentedWord = "thanks"
                                isKeyboardOpen = false
                            }
                            if userData.step == 7 {
                             
                            }
                            }
                    
                    
                        if isKeyboardOpen {
                       text = " "
                        } else {
                            text = "Type Here"
                        }
                        
                        
                }
                } .padding()
            if isKeyboardOpen {
               
               
               // Spacer(minLength: screenSize.height/2.5)
                MotionView3(x: $x, y:$y, z:$z, text: $text, isKeyboardOpen: $isKeyboardOpen, keyNum: $keyNum, keyNum2: $keyNum2, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2)
                        .environmentObject(UserData.shared)
                    .ignoresSafeArea()
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
        mailString.append("Mistypes, time\n")
        i = 0
        for x in x {
        mailString.append("\(keysMistyped[i]),\(time)\n")
            i += 1
        }
        // Converting it to NSData.
      
        
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
        let riversRef = storageRef.child("Zoom-\(userData.intentedWord)-\(UUID()).csv")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
          print(error)
            return
          }
       }
    }
    func createCSV() {
        let fileName = "exportar_serv.csv"

        /* CREAR UN ARCHIVO NUEVO EN EL DIRECTORIO PRINCIPAL */
        guard let path = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName) as NSURL else {
            return }

        var csvText = "\("keys"),\("x"),\("y"),\("z")\n"

        for task in taskArr {
       

            let newLine = "\(task.keysMistyped),\(task.x),\(task.y), \(task.z)\n"
            csvText.append(newLine)
        } // for

        do {
            try csvText.write(to: path as URL, atomically: true, encoding: String.Encoding.utf8)
            print("DATOS GUARDADOS")
        
        } catch {
            print("Failed to create file")
            print("\(error)")
        } // catch

    } // CreateCSV
    func shareButton() {
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
        mailString.append("Mistypes, X, Z\n")
        i = 0
        for x in x {
        mailString.append("\(keysMistyped[i]),\(x),\(z[i]) \n")
            i += 1
        }
        // Converting it to NSData.
      
        
           do {
            try mailString.write(to: path!, atomically: true, encoding: String.Encoding.utf8.rawValue)
           } catch {
               print("Failed to create file")
               print("\(error)")
           }
           print(path ?? "not found")

           var filesToShare = [Any]()
           filesToShare.append(path!)

           let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

           UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

           isShareSheetShowing.toggle()
       }

   
    func createCSVX() {
    var csvString = "\("keys"),\("x"),\("y"),\("z")\n"

   

    let fileManager = FileManager.default
        for task in taskArr {
       

            let newLine = "\(task.keysMistyped),\(task.x),\(task.y), \(task.z)\n"
            csvString.append(newLine)
        } // for
    do {

    let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil , create: false )

    let fileURL = path.appendingPathComponent("TrailTime.csv")

    try csvString.write(to: fileURL, atomically: true , encoding: .utf8)
    } catch {

    print("error creating file")
       
    }

    

    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  }
           
