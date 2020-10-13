//
//  Keyboard.swift
//  Keyboard
//
//  Created by Andreas Ink on 10/8/20.
//

import SwiftUI
import UIKit
struct Keyboard: View {
    @EnvironmentObject var userData: UserData
    
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
    @State var zoomed: Bool
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
    @State var text: String = ""
    @State var key: String = ""
    @State var time: Double = 0.0
    weak var delegate: KeyboardViewControllerDelegate?
    @State var x: [Double] = [0.0]
    
    @State var y: [Double] = [0.0]
    
    @State var z: [Double] = [0.0]
    
    @State var isKeyboardOpen: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
        VStack {
           // Spacer(minLength: screenSize.height/1.7)
            Color(.clear)
                .onAppear() {
                    let defaults = UserDefaults.standard
                    let timeNew = defaults.double(forKey: "timeNew")
                    let timeReg = defaults.double(forKey: "timeReg")
                    print("timeNew: \(timeNew)")
                    print("timeReg: \(timeReg)")
                    
                   
                            
                            
                        
                            
                    
                }
         
            ZStack(alignment: .center) {
                Image("keyboardBackground")
                    .resizable()
                    //.frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
              
                VStack {
                    
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(data, id: \.self) { item in
                        ZStack {
                            
                            if item != "backspace" {
                                if item != "space" {
                                    Color(.white)
                                        .frame(width: screenSize.width/13, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.headline)
                                }
                            }
                            if item == "backspace" {
                               // Color(.white)
                                    //.frame(width: screenSize.width/9, height: screenSize.width/8, alignment: .center)
                                    //.padding(.leading)
                            }
                           
                        } .onTapGesture {
                             key = item
                            
                        }
                        .padding(3)
                    }
                    
                    
                   
                }
                .padding()
                    Color(.white)
                        .frame(width: screenSize.width/1.1, height: 20)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            text += " "
                            if text == "Type here" {
                                text = ""
                            }
                        })
                        .padding(.bottom, 22)
                }
            }
            .onTapGesture {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    time += 0.1
                    let defaults = UserDefaults.standard
                    defaults.set(time, forKey: "timeNew")
                   
                    if text.contains("k") {
                        timer.invalidate()
                    }
                }
            }
            .simultaneousGesture( DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { dragGesture in
               
               let xPos = dragGesture.location.x
              let yPos = dragGesture.location.y
           
           print(yPos)
                if yPos < screenSize.height * 8/9 {
           if xPos > screenSize.width * 1/3 {
               if xPos < screenSize.width * 2/3 {
                   print(1)
                   zoom2.toggle()
                zoomed.toggle()
               }
           }
               if xPos > screenSize.width * 2/3 {
                   if xPos < screenSize.width {
                       print(2)
                       zoom3.toggle()
                    zoomed.toggle()
                   }
               }
               if xPos > 0 {
                   if xPos < screenSize.width * 1/3 {
                       print(0)
                       zoom1.toggle()
                    zoomed.toggle()
                   }
               }
                }
       })
              
            }
            if zoom1 {
                Image("keyboardBackground")
                    .resizable()
                   // .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        zoom1.toggle()
                        zoomed.toggle()
                    }
                VStack {
                   // Spacer(minLength: screenSize.height/2.5)
                    Text(text)
                        
                        .font(.headline)
                        .padding()
                        .frame(width: screenSize.width/1.5, alignment: .leading)
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                text += item
                                let defaults = UserDefaults.standard
                                defaults.set(key, forKey: "key")
                                zoom1.toggle()
                                zoomed.toggle()
                                
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 42)
            }
            if zoom2 {
                Image("keyboardBackground")
                    .resizable()
                   // .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        zoom1.toggle()
                        zoomed.toggle()
                    }
                VStack {
                   // Spacer(minLength: screenSize.height/2.5)
                    Text(text)
                        
                        .font(.headline)
                        .padding()
                        .frame(width: screenSize.width/1.5, alignment: .leading)
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                text += item
                                delegate?.update(item)
                                zoom2.toggle()
                                zoomed.toggle()
                                
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 42)
            }
            
            if zoom3 {
               
                Image("keyboardBackground")
                    .resizable()
                   // .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        zoom1.toggle()
                        zoomed.toggle()
                    }
                VStack {
                   // Spacer(minLength: screenSize.height/2.5)
                    Text(text)
                        
                        .font(.headline)
                        .padding()
                        .frame(width: screenSize.width/1.5, alignment: .leading)
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/6, height: screenSize.width/10, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                text += item
                                delegate?.update(item)
                                zoom3.toggle()
                                zoomed.toggle()
                                
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 42)
            }
        }
      
    }
    
}
