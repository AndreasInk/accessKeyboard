//
//  MotionView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/12/20.
//

import SwiftUI
import SwiftUICharts
import Firebase
struct MotionView: View {
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @ObservedObject var motionManager = MotionManager()
    
    
    
    @State var keyMistyped: Int = 0
    @State var step: Int = 0
   
    
    @State var averageZ = 0.0
    
    @EnvironmentObject var userData: UserData
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    @Binding var text: String 
    let columns = [
        GridItem(.adaptive(minimum: 30))
    ]
    let columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State var keyTime = [Double]()
    
    @Binding var isKeyboardOpen: Bool
    
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    @Binding var keysMistyped: [Double]
    @Binding var time: Double
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.white)
                .onTapGesture {
                    isKeyboardOpen = false
                    text = "Type Here"
                }
            if userData.canRememberMotion {
                Color(.white)
            .onAppear() {
                
                _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                   
                    time += 0.1
                   //left and right
                    
                    x.append(motionManager.x)
                    //diagonal
                    y.append(motionManager.y)
                    //up and down
                    z.append(motionManager.z)
                    
                    keysMistyped.append(0)
                    
                    print(motionManager.z)
                    if time == 10 {
                        let sumArray = z.reduce(0, +)

                        averageZ = sumArray / Double(z.count)
                        
                        
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
                        
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(data, id: \.self) { item in
                            ZStack(alignment: .center) {
                                
                                if item != "backspace" {
                                    if item != "space" {
                                        Color(.white)
                                            .frame(width: screenSize.width/11, height: screenSize.width/8, alignment: .center)
                                        Text(item)
                                            .font(.headline)
                                    }
                                }
                                if item == "backspace" {
                                    Color(.white)
                                        .frame(width: screenSize.height/15, height: screenSize.height/14, alignment: .center)
                                        .padding(.leading)
                                }
                               
                            }  .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                
                               
                                if item == "backspace" {
                                    if text.count > 0 {
                                text.removeLast()
                                        keyNum -= 1
                                    }
                                } else {
                                    text += item
                                    keyNum += 1
                                }
                              
                            })
                            .padding()
                        }
                        
                        
                       
                    }
                    
                    .padding()
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: 50)
                            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                text += " "
                            })
                            .padding(.bottom, 22)
                    }
                } 
               
                
    }
        }
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
