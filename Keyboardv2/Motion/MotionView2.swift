//
//  MotionView2.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI

import SwiftUI
import CoreMotion

struct MotionView2: View {
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @ObservedObject var motionManager = MotionManager()
    
    
    
    @State var keyMistyped: Int = 0
    @State var step: Int = 0
   
    
    @State var averageX = 0.0
    
    @EnvironmentObject var userData: UserData
   
    let screenSize = UIScreen.main.bounds
    @Binding var text: String
    
    let columns1 = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State var keyTime = [Double]()
    
    @Binding var isKeyboardOpen: Bool
    
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    @Binding var keysMistyped: [Double]
    
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }

    
    @State var horizontal11 = (["q", "w", "e", "r", "t", "y","u", "i", "o", "p" ]).map { "\($0)" }
    @State var horizontal22 = (["a", "s", "d", "f", "g", "h", "j", "k", "l"]).map { "\($0)" }
    @State var horizontal33 = (["z", "x", "c", "v", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    
    
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
  
    @State var key: String = ""

   
    
    @State var keys = [String]()
   
    @Binding var wait: Bool 
    
    @State var calibrate: Bool = false
    @Binding var time: Double
    @Binding var timeOn: Bool
    @Binding var keysMistyped2: [String]
    
    @State var columns = [GridItem]()
    var body: some View {
        ZStack(alignment: .bottom) {
            if wait {
                CalibrateView(wait: $wait, time: $time, x: $x, y: $y, z: $z, averageX: $averageX)
                    
                
            } else {
         
                Color(.white)
                    .onAppear() {
                        if screenSize.height > 812 {
                        self.columns =  [GridItem(.adaptive(minimum: 35))]
                           
                          
                        } else {
                            self.columns =  [GridItem(.adaptive(minimum: 30))]
                        }
                    }
                    .onDisappear() {
                        columns.removeAll()
                    }
                    .onAppear() {
                       
                        var timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 120, repeats: true) { timer in
                            if timeOn {
                           //left and right
                                time += 0.1
                            x.append(motionManager.x)
                            //diagonal
                            y.append(motionManager.y)
                            //up and down
                            z.append(motionManager.z)
                            keysMistyped.append(0)
                            
                         
                               
                            }
                            if userData.step == 12 {
                                timer.invalidate()
                            }
                        }
                    }
        VStack {
          //  Spacer(minLength: screenSize.height/1.7)
                
                
        
            ZStack(alignment: .bottom) {
                
                BlurView(style: .systemThickMaterial)
                    .frame(width: screenSize.width, height: screenSize.height/2.3, alignment: .center)
               
                    .simultaneousGesture( DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { dragGesture in
                        timeOn = true
                        
                            
                       let xPos = dragGesture.location.x
                      let yPos = dragGesture.location.y
                        if x.last != nil {
                        let equation = 0.102703567 * x.last!
                        let startNumber = averageX - 0.17
                        let endNumber = averageX + 0.17
                        let numberRange = startNumber...endNumber
                   print(yPos)
                        if yPos < screenSize.height * 8/9 {
                   if xPos > screenSize.width * 1/3 {
                       if xPos < screenSize.width * 2/3 {
                           print(1)
                        if equation + 0.166815418 > 0.18 {
                           zoom2.toggle()
                       
                       }
                   }
                   }
                        
                       if xPos > screenSize.width * 2/3 {
                           if xPos < screenSize.width {
                               print(2)
                            if equation + 0.166815418 > 0.18 {
                                
                           
                               zoom3.toggle()
                           
                           }
                       }
                       }
                       if xPos > 0 {
                           if xPos < screenSize.width * 1/3 {
                               print(0)
                            if equation + 0.166815418 > 0.18 {
                                
                           
                               zoom1.toggle()
                           
                           }
                       }
                        }
                        }
                        }
               })
                VStack {
                    
                    
                    KeyboardRow(data: horizontal11, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, averageX: $averageX, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3)
                    KeyboardRow(data: horizontal22, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, averageX: $averageX, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3)
                    KeyboardRow(data: horizontal33, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $z, y: $y, z: $z, averageX: $averageX, zoom1: $zoom1, zoom2: $zoom2, zoom3: $zoom3)
                        
                
                       
                       
                      
                    }
                    
                    
                   
                
                .padding(.horizontal, 6)
                .padding(.bottom, 100)
                    Button(action: {
                        text += " "
                        
                        if userData.step < 12 {
                          print("\(userData.intentedWord[keyNum])")
                          
                           if "\(userData.intentedWord[keyNum])" != " " {
                               keysMistyped.append(0.5)
                                       keysMistyped2.append("\(userData.intentedWord[keyNum])")
                               
                               if keyNum > -1 {
                              // text.removeLast()
                              // text.append(userData.intentedWord[keyNum])
                               
                           }
                           }
                           
                          
                           
                    }
                       keyNum2 += 1
                       keyNum += 1
                    }) {
                    Color(.white)
                        .frame(width: screenSize.width/1.1, height: 50)
                       
                       
                    }
                }
            } .padding(.bottom, 22)
           
          
              
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
                                
                                if userData.step < 12 {
                                   print("\(userData.intentedWord[keyNum])")
                                   
                                    if "\(userData.intentedWord[keyNum])" != item {
                                        keysMistyped.append(0.5)
                                                keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                        
                                        if keyNum > -1 {
                                       // text.removeLast()
                                        //text.append(userData.intentedWord[keyNum])
                                        
                                    }
                                    }
                                    
                                   
                                    
                             }
                                keyNum2 += 1
                                keyNum += 1
                                
                              
                               
                                print(keys)
                                
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
                   
                } .padding(.bottom, 200)
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
                                
                               if userData.step < 12 {
                                  print("\(userData.intentedWord[keyNum])")
                                  
                                   if "\(userData.intentedWord[keyNum])" != item {
                                       keysMistyped.append(0.5)
                                               keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                       
                                       if keyNum > -1 {
                                       text.removeLast()
                                       text.append(userData.intentedWord[keyNum])
                                       
                                   }
                                   }
                                   
                                  
                                   
                            }
                               keyNum2 += 1
                               keyNum += 1
                               
                               
                               
                               
                           
                               
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
                            }
                                
                            
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 200)
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
                                    }
                                } else {
                                    text += item
                                    
                                    if userData.step < 12 {
                                      print("\(userData.intentedWord[keyNum])")
                                      
                                       if "\(userData.intentedWord[keyNum])" != item {
                                           keysMistyped.append(0.5)
                                                   keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                           
                                           if keyNum > -1 {
                                           text.removeLast()
                                           text.append(userData.intentedWord[keyNum])
                                           
                                       }
                                       }
                                       
                                      
                                       
                                }
                                   keyNum2 += 1
                                   keyNum += 1
                                }
                                
                                
                                
                               
                               
                               
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
                                
                            }
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 200)
            }
            
         //.frame(height: 200)
       
    }
    }
}
