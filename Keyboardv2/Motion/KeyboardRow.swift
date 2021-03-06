//
//  KeyboardRow.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/27/20.
//

import SwiftUI

struct KeyboardRow: View {
    @State var data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    let screenSize = UIScreen.main.bounds
    @Binding var text: String
    @Binding var keysMistyped: [Double]
    @Binding var time: Double
    @Binding var timeOn: Bool
    @Binding var keysMistyped2: [String]
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
   
    
    @Binding var zoom1: Bool
    @Binding var zoom2: Bool
    @Binding var zoom3: Bool
    @EnvironmentObject var userData: UserData
    @Binding var prediction: Double
    @Binding var predictionZ: Double
    
   
    @ObservedObject var motionManager = MotionManager()
    @Binding var counter: Int
    var body: some View {
        HStack() {
            
      
            ForEach(data, id: \.self) { item in
            // Spacer()
                Button(action: {
                    timeOn = true
                   
                     if item == "backspace" {
                         if text.count > 0 {
                     text.removeLast()
                             keyNum -= 1
                         }
                     } else {
                         text += item
                         
                        if userData.step > 0 {
                           print("\(userData.intentedWord[keyNum])")
                           print(keyNum)
                            if "\(userData.intentedWord[keyNum])" != item {
                                keysMistyped.append(0.2)
                                        keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                counter += 1
                                if keyNum > -1 {
                                text.removeLast()
                                text.append(userData.intentedWord[keyNum])
                                
                            }
                            }
                            
                           
                            
                     }
                        
                        keyNum2 += 1
                        keyNum += 1
                     }
                     
                     
                }) {
                   
                ZStack(alignment: .center) {
                    
                    if item != "backspace" {
                        if item != "space" {
                            Color(.white)
                                .frame(minWidth: 20, idealWidth: 30, maxWidth: 30, minHeight: 35, idealHeight: 45, maxHeight: 50, alignment: .center)
                            Text(item)
                                .font(.headline)
                               // .padding(5)
                               // .background(Color.white)
                                 
                        .foregroundColor(.black)
                        }
                    }
                    if item == "backspace" {
                        Color(.white)
                            .frame(width: screenSize.height/15, height: screenSize.height/14, alignment: .center)
                            Image("backspace-arrow")
                                .resizable()
                                .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                            .padding(.trailing)
                    }
                }
                }          .simultaneousGesture( DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { dragGesture in
                    timeOn = true
                    
                        
                   let xPos = dragGesture.location.x
                  let yPos = dragGesture.location.y
                    if x.last != nil {
                        let equation = 1.002667789574 * x.last!
                  
                   
               print(yPos)
                    if yPos < screenSize.height * 8/9 {
               if xPos > screenSize.width * 1/3 {
                   if xPos < screenSize.width * 2/3 {
                       print(1)
                    if prediction > -0.09 {
                       zoom2.toggle()
                   
                   }
               }
               }
                    
                   if xPos > screenSize.width * 2/3 {
                       if xPos < screenSize.width {
                           print(2)
                        if prediction > -0.09  {
                            
                       
                           zoom3.toggle()
                       
                       }
                   }
                   }
                   if xPos > 0 {
                       if xPos < screenSize.width * 1/3 {
                           print(0)
                        if prediction > -0.09  {
                            
                       
                           zoom1.toggle()
                       
                       }
                   }
                    }
                    }
                    }
           })
                
            
            
            
           
        }
    }
}

}
