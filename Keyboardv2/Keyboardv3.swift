//
//  Keyboardv3.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI
import SwiftUICharts
struct Keyboardv3: View {
    @State var x = [Double]()
    
    @State var y = [Double]()
    
    @State var z = [Double]()
    
    @ObservedObject var motionManager = MotionManager()
    
    @State var time: Double = 0.0
    
    @State var keyMistyped: Int = 0
    @State var keysMistyped = [Double]()
    
    @State var averageZ = 0.0
    @State var keyNum: Int = 0

    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    let columns = [
        GridItem(.adaptive(minimum: 30))
    ]
    let columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack(alignment: .center) {
           // LineChartView(data: z, title: "Title", legend: "Legendary")
            HStack {
            MultiLineChartView(data: [(z, GradientColors.green), (keysMistyped, GradientColors.purple)], title: "Z")
                
            MultiLineChartView(data: [(x, GradientColors.blu), (keysMistyped, GradientColors.purple)], title: "X")
            }
                .offset(y: 200)
            .onAppear() {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
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
            
            VStack(alignment: .center) {
                Spacer(minLength: screenSize.height/2.5)
                
                TextField("Type", text: $text)
                    .padding()
                ZStack(alignment: .center) {
                    
                    BlurView(style: .systemChromeMaterialLight)
                  
                    GridStack(rows: 4, columns: 4) { row, col in
                       
                        Text("R\(row) C\(col)")
                    }
                    
                    .padding()
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: 50)
                            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                text += " "
                            })
                           
                    }
                } .padding(.bottom, 82)
               
                
    }
        }
    }

