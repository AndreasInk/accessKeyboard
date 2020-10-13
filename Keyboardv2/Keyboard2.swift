//
//  Keyboard2.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/6/20.
//

import SwiftUI

struct Keyboard2: View {
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    @State var time: Double = 0.0
    let columns = [
        GridItem(.adaptive(minimum: 30))
    ]
    let columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        ZStack {
        VStack {
            Spacer(minLength: screenSize.height/1.7)
            
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
        } .onTapGesture {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                time += 0.1
                let defaults = UserDefaults.standard
                defaults.set(time, forKey: "timeReg")
                if text.contains("k") {
                    timer.invalidate()
                }
            }
        }
    }
}


struct Keyboard2_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard2()
    }
}
