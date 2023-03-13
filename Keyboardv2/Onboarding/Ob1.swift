//
//  Ob1.swift
//  Proxima.Ai
//
//  Created by Andreas Ink on 10/3/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct Ob1: View {
  @State var screenSize = UIScreen.main.bounds
    @State var animate: Bool = false
    @State var animate2: Bool = false
    @Binding var next: Int
    @State var dismiss: Bool = false
    var body: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
            Image("background")
                .ignoresSafeArea()
                .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
           
                
               // .offset(x: 500, y: -100)
                .onAppear() {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate.toggle()
                }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            animate2.toggle()
                        }
                    }
                }
                   
            VStack {
                Spacer()
                if animate {
            Text("Access AI")
                        .font(.largeTitle).bold()
                .foregroundColor(.white)
                .offset(x: 0, y: 30)
                .transition(.opacity)
                    
            //Image("Ai")
               // .resizable()
               // .scaledToFit()
               // .frame(width: 100, height: 100, alignment: .center)
                    Spacer()
                    if animate2 {
                    Button(action: {
                        withAnimation() {
                            next += 1
                            dismiss.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.white))
                                .padding()
                                
                                .frame(height: 85)
                            Text("Welcome")
                                .font(.headline)
                                .foregroundColor(Color(.systemPink))
                                .multilineTextAlignment(.center)
                                
                        
                        
                        
                    } 
                       
                    }  .transition(.opacity)
                    }
                }
                Spacer()
            } .padding()
                } .opacity(dismiss ? 0 : 1)
        
    }
}

