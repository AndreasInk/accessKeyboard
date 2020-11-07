//
//  KeyboardRow2.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/27/20.
//

import SwiftUI

struct KeyboardRow2: View {
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
    @ObservedObject var motionManager = MotionManager()
    @Binding var counter: Int
    @EnvironmentObject var userData: UserData
    
    @Binding var pitch: [Double]
    
    @Binding var roll: [Double]
    
    @Binding var yaw: [Double]
    
    @Binding var rotX: [Double]
    
    @Binding var rotY: [Double]
    
    @Binding var rotZ: [Double]
    var body: some View {
        HStack() {
            
      
            ForEach(data, id: \.self) { item in
             //Spacer()
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
                                x.append(x.last ?? motionManager.x)
                                //diagonal
                                y.append(y.last ?? motionManager.y)
                                //up and down
                                z.append(z.last ?? motionManager.z)
                                
                                pitch.append(pitch.last ?? motionManager.pitch)
                                //diagonal
                                roll.append(roll.last ?? motionManager.roll)
                                //up and down
                                yaw.append(yaw.last ?? motionManager.yaw)
                                
                                rotX.append(rotX.last ?? motionManager.rotZ)
                                //diagonal
                                rotY.append(rotY.last ?? motionManager.rotY)
                                //up and down
                                rotZ.append(rotZ.last ?? motionManager.rotZ)
                                counter += 1
                                if keyNum > -1 {
                              //  text.removeLast()
                                    //  text.append(userData.intentedWord[keyNum])
                                
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
                        ZStack {
                       
                            Image("backspace-arrow")
                                .resizable()
                                .scaledToFill()
                               
                            .frame(width: 40, height: 30, alignment: .center)
                            .padding(.trailing)
                               // .background(Color(.white))
                    }
                    }
                }
                }          
                
            
            
            
           
        }
    }
}

}
