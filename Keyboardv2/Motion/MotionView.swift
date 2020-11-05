//
//  MotionView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/12/20.
//

import SwiftUI

import Firebase

struct MotionView: View {
    
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
    @State var horizontal1 = (["q", "w", "e", "r", "t", "y","u", "i", "o", "p" ]).map { "\($0)" }
    @State var horizontal2 = (["a", "s", "d", "f", "g", "h", "j", "k", "l"]).map { "\($0)" }
    @State var horizontal3 = (["z", "x", "c", "v", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    @Binding var text: String 
   @State var columns = [GridItem]()
    var columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State var keyTime = [Double]()
    
    @Binding var isKeyboardOpen: Bool
    
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    @Binding var keysMistyped: [Double]
    @Binding var time: Double
    @Binding var timeOn: Bool
    @Binding var keysMistyped2: [String]
    @Binding var counter: Int
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
                    counter += 1
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
                        .frame(width: screenSize.width, height: screenSize.height/2.5, alignment: .center)
                   
                    VStack(alignment: .center) {
                        Spacer()
                        KeyboardRow2(data: horizontal1, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $x, y: $y, z: $z, counter: $counter, pitch: $pitch, roll: $roll, yaw: $yaw, rotX: $rotX, rotY: $rotY, rotZ: $rotZ)
                       
                        KeyboardRow2(data: horizontal2, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $x, y: $y, z: $z, counter: $counter, pitch: $pitch, roll: $roll, yaw: $yaw, rotX: $rotX, rotY: $rotY, rotZ: $rotZ)
                        KeyboardRow2(data: horizontal3, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, x: $x, y: $y, z: $z, counter: $counter, pitch: $pitch, roll: $roll, yaw: $yaw, rotX: $rotX, rotY: $rotY, rotZ: $rotZ)
                       
                        Spacer()
                    }
                    
                    .padding(.bottom, 50)
                        Button(action: {
                            text += " "
                            
                           if userData.step > 0 {
                              print("\(userData.intentedWord[keyNum])")
                              
                               if "\(userData.intentedWord[keyNum])" != " " {
                                   keysMistyped.append(0.2)
                                           keysMistyped2.append("\(userData.intentedWord[keyNum])")
                                   
                                   if keyNum > -1 {
                                   //text.removeLast()
                                  // text.append(userData.intentedWord[keyNum])
                                   
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
    } 
        } 
    }

    public enum ButtonState {
        case pressed
        case notPressed
    }

    /// ViewModifier allows us to get a view, then modify it and return it
    public struct TouchDownUpEventModifier: ViewModifier {
        
        /// Properties marked with `@GestureState` automatically resets when the gesture ends/is cancelled
        /// for example, once the finger lifts up, this will reset to false
        /// this functionality is handled inside the `.updating` modifier
        @GestureState private var isPressed = false
        
        /// this is the closure that will get passed around.
        /// we will update the ButtonState every time your finger touches down or up.
        let changeState: (ButtonState) -> Void
        
        /// a required function for ViewModifier.
        /// content is the body content of the caller view
        public func body(content: Content) -> some View {
            
            /// declare the drag gesture
            let drag = TapGesture()
                
                /// this is called whenever the gesture is happening
                /// because we do this on a `DragGesture`, this is called when the finger is down
                .updating($isPressed) { (value, gestureState, transaction) in
                    
                /// setting the gestureState will automatically set `$isPressed`
                gestureState = true
            }
            
            return content
            .gesture(drag) /// add the gesture
            .onChange(of: isPressed, perform: { (pressed) in /// call `changeState` whenever the state changes
                /// `onChange` is available in iOS 14 and higher.
                if pressed {
                    self.changeState(.pressed)
                   
                    
                } else {
                    self.changeState(.notPressed)
                }
            })
        }
        
        /// if you're on iPad Swift Playgrounds and you put all of this code in a seperate file,
        /// you need to add a public init so that the compiler detects it.
        public init(changeState: @escaping (ButtonState) -> Void) {
            self.changeState = changeState
        }
    }
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
