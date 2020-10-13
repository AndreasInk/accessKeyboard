//
//  Hybrid.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/6/20.
//

import SwiftUI
import CoreMotion

struct Hybrid: View {
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    let columns = [
        GridItem(.adaptive(minimum: 30))
    ]
    let columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
    @State var text: String = ""
    @State var key: String = ""
    @State var time: Double = 0.0
    
    @State var x = [Double]()
    
    @State var y = [Double]()
    
    @State var z = [Double]()
    
    @State var keys = [String]()
    @ObservedObject var motionManager = MotionManager()
    var body: some View {
        ZStack {
        VStack {
            Spacer(minLength: screenSize.height/1.7)
                .onAppear() {
                    let defaults = UserDefaults.standard
                    let timeNew = defaults.double(forKey: "timeNew")
                    let timeReg = defaults.double(forKey: "timeReg")
                    let timeHybrid = defaults.double(forKey: "timeHybrid")
                    print("timeNew: \(timeNew)")
                    print("timeReg: \(timeReg)")
                    print("timeHybrid: \(timeHybrid)")
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    //print(motionManager.x)
                   // print(motionManager.y)
                    
                    }
                    }
                
            TextField("Type", text: $text)
                .padding()
            ZStack {
                
                BlurView(style: .systemChromeMaterialLight)
                    .simultaneousGesture( DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { dragGesture in
                       
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
                           
                        } .onTapGesture {
                             key = item
                          
                            if item == "backspace" {
                                if text.count > 0 {
                            text.removeLast()
                                }
                            } else {
                                text += item
                            }
                        }
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
            .onTapGesture {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    time += 0.1
                    let defaults = UserDefaults.standard
                    defaults.set(time, forKey: "timeHybrid")
                    
                    if text.contains("k") {
                        timer.invalidate()
                    }
                }
            }
          
              
            }
            if zoom1 {
                Color(.blue)
                    .onTapGesture() {
                        zoom1.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/1.7)
                       
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            ZStack {
                                
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                text += item
                                
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                keys.append(item)
                                print(keys)
                                print(x)
                                zoom1.toggle()
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 62)
            }
            if zoom2 {
                Color(.blue)
                    .onTapGesture() {
                        zoom2.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/1.7)
                       
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal2, id: \.self) { item in
                            ZStack {
                               
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                text += item
                               
                                text += item
                               
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                keys.append(item)
                                print(keys)
                                print(x)
                                zoom2.toggle()
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 62)
            }
            if zoom3 {
                Color(.blue)
                    .onTapGesture() {
                        zoom3.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/1.7)
                       
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal3, id: \.self) { item in
                            ZStack {
                               
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                
                                
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if item == "backspace" {
                                    if text.count > 0 {
                                text.removeLast()
                                    }
                                } else {
                                    text += item
                                }
                                
                                text += item
                                zoom1.toggle()
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                keys.append(item)
                                print(keys)
                                print(x)
                                zoom3.toggle()
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 62)
            }
        } .frame(height: 200)
      
    }
}
struct Hybrid_Previews: PreviewProvider {
    static var previews: some View {
        Hybrid()
    }
}
