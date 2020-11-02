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
    
    @State var horizontal1 = (["q", "w", "e", "a", "s", "d","z", "x", "c" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "t", "y", "u", "f", "g", "h", "v", "b"]).map { "\($0)" }
    @State var horizontal3 = (["i", "o", "p", "j", "k", "l", "n", "m", "backspace"]).map { "\($0)" }
    var body: some View {
        HStack(spacing: 0) {
            
      
            ForEach(data, id: \.self) { item in
             Spacer()
                Button(action: {
                    timeOn = true
                   key = item
                   
                    
                        
             
              
                    if horizontal1.contains(item) {
                        zoom1.toggle()
                    }
                    if horizontal2.contains(item) {
                        zoom2.toggle()
                    }
                    if horizontal3.contains(item) {
                        zoom3.toggle()
                    }
                     if item == "backspace" {
                         if text.count > 0 {
                     text.removeLast()
                             keyNum -= 1
                         }
                     } else {
                       //  text += item
                         
                        if userData.step > 0 {
                           print("\(userData.intentedWord[keyNum])")
                           print(keyNum)
                            if "\(userData.intentedWord[keyNum])" != item {
                                keysMistyped.append(0.2)
                                        keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                
                                if keyNum > -1 {
                             //   text.removeLast()
                               // text.append(userData.intentedWord[keyNum])
                                
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
                }
                  
          
                
            
            
            
           
        }
    }
}

}
