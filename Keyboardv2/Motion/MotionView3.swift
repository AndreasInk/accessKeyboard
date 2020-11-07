//
//  MotionView3.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/27/20.
//

import SwiftUI

import Firebase

struct MotionView3: View {
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @Binding var pitch: [Double]
    
    @Binding var roll: [Double]
    
    @Binding var yaw: [Double]
    
    @Binding var rotX: [Double]
    
    @Binding var rotY: [Double]
    
    @Binding var rotZ: [Double]
    
    @ObservedObject var motionManager = MotionManager()
    
    
    
    @State var keyMistyped: Int = 0
    @State var step: Int = 0
   
    
    @State var averageZ = 0.0
    
    @EnvironmentObject var userData: UserData
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "w", "e", "a", "s", "d","z", "x", "c" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "t", "y", "u", "f", "g", "h", "v", "b"]).map { "\($0)" }
    @State var horizontal3 = (["i", "o", "p", "j", "k", "l", "n", "m", "backspace"]).map { "\($0)" }
    
    @State var horizontal11 = (["q", "w", "e", "r", "t", "y","u", "i", "o", "p" ]).map { "\($0)" }
    @State var horizontal22 = (["a", "s", "d", "f", "g", "h", "j", "k", "l"]).map { "\($0)" }
    @State var horizontal33 = (["z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    
    let screenSize = UIScreen.main.bounds
    @Binding var text: String
   @State var columns = [GridItem]()
    var columns1 = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State var keyTime = [Double]()
    
    @Binding var isKeyboardOpen: Bool
    
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    @Binding var keysMistyped: [Double]
    @Binding var time: Double
    @Binding var timeOn: Bool
    @Binding var keysMistyped2: [String]
    
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
    
    @State var key: String = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.white)
                .onAppear() {
                    print(screenSize.height)
                    if screenSize.height > 812 {
                    self.columns =  [GridItem(.adaptive(minimum: 35))]
                       
                      
                    } else {
                        self.columns =  [GridItem(.adaptive(minimum: 30))]
                    }
                }
                
                .onDisappear() {
                    columns.removeAll()
                   
                }
                .onTapGesture {
                    isKeyboardOpen = false
                    text = "Type Here"
                }
            if userData.canRememberMotion {
                Color(.white)
            .onAppear() {
                
                _ = Timer.scheduledTimer(withTimeInterval: 1.0 / 120, repeats: true) { timer in
                  
                  
                   //left and right
                    if timeOn {
                        
                        time += 0.1
                    x.append(motionManager.x)
                    //diagonal
                    y.append(motionManager.y)
                    //up and down
                    z.append(motionManager.z)
                    
                        pitch.append(motionManager.pitch)
                        //diagonal
                        roll.append(motionManager.roll)
                        //up and down
                        yaw.append(motionManager.yaw)
                        
                        rotX.append(motionManager.rotX)
                        //diagonal
                        rotY.append(motionManager.rotY)
                        //up and down
                        rotZ.append(motionManager.rotZ)
                        
                        keysMistyped.append(-0.099)
                    
                    //print(motionManager.z)
                    if time == 10 {
                        let sumArray = z.reduce(0, +)

                        averageZ = sumArray / Double(z.count)
                        
                        
                    }
                       
                }
                    if userData.step == 6 {
                        timer.invalidate()
                    }
                }
                }
            } else {
                Color(.white)
            .onAppear() {
                
               print("NOPE")
                }
            }
        
            
            
            VStack(alignment: .center) {
                //
               
                ZStack(alignment: .bottom) {
                    
                    BlurView(style: .systemThickMaterial)
                        .frame(width: screenSize.width, height: screenSize.height/2, alignment: .center)
                  
                    VStack(alignment: .center) {
                        
                  
                        KeyboardRow3(data: horizontal11, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3, key: $key)
                        KeyboardRow3(data: horizontal22, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3, key: $key)
                        KeyboardRow3(data: horizontal33, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3, key: $key)
                        
                     
                         
                        
                        
                       
                    } 
                    .padding(.bottom, 100)

                    
                        Button(action: {
                            text += " "
                            
                           if userData.step > 0 {
                              print("\(userData.intentedWord[keyNum])")
                              
                               if "\(userData.intentedWord[keyNum])" != " " {
                                   keysMistyped.append(0.2)
                                           keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                pitch.append(pitch.last!)
                                //diagonal
                                roll.append(roll.last!)
                                //up and down
                                yaw.append(yaw.last!)
                                
                                rotX.append(rotX.last!)
                                //diagonal
                                rotY.append(rotY.last!)
                                //up and down
                                rotZ.append(rotZ.last!)
                                   if keyNum > -1 {
                                 //  text.removeLast()
                                 //  text.append(userData.intentedWord[keyNum])
                                   
                               }
                               }
                               
                              
                               
                        }
                           keyNum2 += 1
                           keyNum += 1
                        }) {
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: 50)

                            .padding(.bottom, 22)
                                
                    }
                }
               
                }
            if zoom1 {
                BlurView(style: .systemThickMaterial)
                  
                    .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture() {
                        zoom1.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/3)
                    Text(text)
                        
                        .font(.headline)
                        .frame(width: screenSize.width/1.4, height: 120, alignment: .leading)
                    Button(action: {
                        zoom1.toggle()
                    }) {
                        ZStack {
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: screenSize.width/5.5, alignment: .center)
                        Text("Back")
                            .font(.title)
                            .foregroundColor(.black)
                        }
                    }
                       
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            Button(action: {
                                text += item
                                
                               
                                   print("\(userData.intentedWord[keyNum])")
                                   
                                    if "\(userData.intentedWord[keyNum])" != item {
                                        keysMistyped.append(0.2)
                                                keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                        pitch.append(pitch.last!)
                                        //diagonal
                                        roll.append(roll.last!)
                                        //up and down
                                        yaw.append(yaw.last!)
                                        
                                        rotX.append(rotX.last!)
                                        //diagonal
                                        rotY.append(rotY.last!)
                                        //up and down
                                        rotZ.append(rotZ.last!)
                                        if keyNum > -1 {
                                       // text.removeLast()
                                        //text.append(userData.intentedWord[keyNum])
                                        
                                    
                                    }
                                    
                                   
                                    
                             }
                                keyNum2 += 1
                                keyNum += 1
                                
                              
                               
                             //   print(keys)
                                
                                zoom1.toggle()
                            }) {
                            ZStack {
                                
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                                
                            }
                            
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 250)
            }
            }
            if zoom2 {
                BlurView(style: .systemThickMaterial)
                  
                    .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture() {
                        zoom2.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/3)
                    Text(text)
                        
                        .font(.headline)
                        .frame(width: screenSize.width/1.4, height: 120, alignment: .leading)
                    Button(action: {
                        zoom2.toggle()
                    }) {
                        ZStack {
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: screenSize.width/5.5, alignment: .center)
                        Text("Back")
                            .font(.title)
                            .foregroundColor(.black)
                        }
                    }
                       
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal2, id: \.self) { item in
                            Button(action: {
                                text += item
                                
                              
                                   print("\(userData.intentedWord[keyNum])")
                                   
                                    if "\(userData.intentedWord[keyNum])" != item {
                                        keysMistyped.append(0.2)
                                                keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                        pitch.append(pitch.last!)
                                        //diagonal
                                        roll.append(roll.last!)
                                        //up and down
                                        yaw.append(yaw.last!)
                                        
                                        rotX.append(rotX.last!)
                                        //diagonal
                                        rotY.append(rotY.last!)
                                        //up and down
                                        rotZ.append(rotZ.last!)
                                        if keyNum > -1 {
                                       // text.removeLast()
                                        //text.append(userData.intentedWord[keyNum])
                                        
                                     
                                    }
                                    
                                   
                                    
                             }
                                keyNum2 += 1
                                keyNum += 1
                                
                              
                               
                             //   print(keys)
                                
                                zoom2.toggle()
                            }) {
                            ZStack {
                                
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                                
                            }
                            
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 250)
            }
            }
         
    
        
        
        if zoom3 {
            BlurView(style: .systemThickMaterial)
              
                .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture() {
                    zoom3.toggle()
                }
            VStack {
                Spacer(minLength: screenSize.height/3)
                Text(text)
                    
                    .font(.headline)
                    .frame(width: screenSize.width/1.4, height: 120, alignment: .leading)
                Button(action: {
                    zoom3.toggle()
                }) {
                    ZStack {
                    Color(.white)
                        .frame(width: screenSize.width/1.1, height: screenSize.width/5.5, alignment: .center)
                    Text("Back")
                        .font(.title)
                        .foregroundColor(.black)
                    }
                }
                   
                LazyVGrid(columns: columns1, spacing: 5) {
                    ForEach(horizontal3, id: \.self) { item in
                        Button(action: {
                            if item == "backspace" {
                                if text.count > 0 {
                            text.removeLast()
                                    keyNum -= 1
                                }
                            } else {
                            text += item
                            }
                          
                               print("\(userData.intentedWord[keyNum])")
                               
                                if "\(userData.intentedWord[keyNum])" != item {
                                    keysMistyped.append(0.2)
                                            keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                    pitch.append(pitch.last!)
                                    //diagonal
                                    roll.append(roll.last!)
                                    //up and down
                                    yaw.append(yaw.last!)
                                    
                                    rotX.append(rotX.last!)
                                    //diagonal
                                    rotY.append(rotY.last!)
                                    //up and down
                                    rotZ.append(rotZ.last!)
                                    if keyNum > -1 {
                                   // text.removeLast()
                                    //text.append(userData.intentedWord[keyNum])
                                    
                                }
                                
                                
                               
                                
                         }
                            keyNum2 += 1
                            keyNum += 1
                            
                          
                           
                         //   print(keys)
                            
                            zoom3.toggle()
                        }) {
                        ZStack {
                            
                            if item == key {
                                Color(.systemBlue)
                                .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                Text(item)
                                    .font(.title)
                                    .foregroundColor(.white)
                            } else {
                                Color(.white)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                Text(item)
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                            
                            
                        }
                        
                        .padding()
                    }
                    
                
               
            }
            .padding()
               
            }.padding(.bottom, 250)
        }
        }
     

    
    }
    }
        


   
}
