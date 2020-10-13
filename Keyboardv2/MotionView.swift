//
//  MotionView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/12/20.
//

import SwiftUI
import SwiftUICharts
struct MotionView: View {
    
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
        VStack {
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
            
            VStack {
                Spacer(minLength: screenSize.height/2.5)
                
                TextField("Type", text: $text)
                    .padding()
                ZStack {
                    
                    BlurView(style: .systemChromeMaterialLight)
                  
                    VStack {
                        
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(data, id: \.self) { item in
                            ZStack {
                                
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
                                        .frame(width: screenSize.width/9, height: screenSize.width/8, alignment: .center)
                                        .padding(.leading)
                                }
                               
                            }  .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                text += item
                                keyNum += 1
                                
                                if keyNum == 1 {
                                if item != "s" {
                                    
                                    keysMistyped.append(0.5)
                                    
                                }
                                }
                                if keyNum == 2 {
                                if item != "t" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 3 {
                                if item != "e" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 4 {
                                if item != "v" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 5 {
                                if item != "e" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 6 {
                                if item != "i" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 7 {
                                if item != "n" {
                                    
                                    keysMistyped.append(0.5)
                                }
                                }
                                if keyNum == 8 {
                                if item != "k" {
                                    
                                    keysMistyped.append(0.5)
                                }
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
                           
                    }
                } .padding(.bottom, 62)
                
    }
        }
    }
}

struct MotionView_Previews: PreviewProvider {
    static var previews: some View {
        MotionView()
    }
}
