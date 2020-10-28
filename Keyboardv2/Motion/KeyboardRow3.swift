//
//  KeyboardRow3.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/27/20.
//

import SwiftUI

struct KeyboardRow3: View {
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
    @Binding var key: String 
    @EnvironmentObject var userData: UserData
    var body: some View {
        HStack() {
            
      
            ForEach(data, id: \.self) { item in
             Spacer()
                Button(action: {
                    timeOn = true
                   key = item
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
                                
                                if keyNum > -1 {
                                text.removeLast()
                                text.append(userData.intentedWord[keyNum])
                                
                            }
                            }
                            
                           
                            
                     }
                        if item == "backspace" {
                            keyNum2 -= 1
                            keyNum -= 1
                        } else {
                        keyNum2 += 1
                        keyNum += 1
                     }
                     }
                     
                }) {
                   
                ZStack(alignment: .center) {
                    
                    if item != "backspace" {
                        if item != "space" {
                            Color(.white)
                                .frame(minWidth: 20, idealWidth: 35, maxWidth: 45, minHeight: 25, idealHeight: 40, maxHeight: 50, alignment: .center)
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
                   
                 
               print(yPos)
                    if yPos < screenSize.height * 8/9 {
               if xPos > screenSize.width * 1/3 {
                   if xPos < screenSize.width * 2/3 {
                       print(1)
                   
                       zoom2.toggle()
                   
                   
               }
               }
                    
                   if xPos > screenSize.width * 2/3 {
                       if xPos < screenSize.width {
                           print(2)
                      
                            
                       
                           zoom3.toggle()
                       
                       
                   }
                   }
                   if xPos > 0 {
                       if xPos < screenSize.width * 1/3 {
                           print(0)
                       
                            
                       
                           zoom1.toggle()
                       
                       
                   }
                    }
                    }
                    
           })
                
            
            
            
           
        }
    }
}

}
