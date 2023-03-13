//
//  Ob2.swift
//  Proxima.Ai
//
//  Created by Andreas Ink on 10/3/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct Ob2: View {
    @Binding var next: Int
    @State var animate: Bool = false
    @State var animate2: Bool = false
    @State var dismiss: Bool = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
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
                Text("A Student Initiative")
                    .font(.largeTitle).bold()
                .multilineTextAlignment(.center)
                    .padding()
                Text("We are designing a digital keyboard to improve the lives of people who have issues typing such as those with neurological diseases.")
                    .font(.subheadline)
                    .padding()
                .multilineTextAlignment(.center)
                    .opacity(0.7)
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
                            .foregroundColor(Color(.systemPink))
                            .padding()
                            
                            .frame(height: 85)
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            
                            .multilineTextAlignment(.center)
                            
                    
                    
                    
                } .padding(.bottom)
                   
                }  .transition(.opacity)
                }
            }
        }   .opacity(dismiss ? 0 : 1)
    }
}

struct Ob3: View {
    @Binding var next: Int
    @State var animate: Bool = false
    @State var animate2: Bool = false
    @State var dismiss: Bool = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
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
                Text("Our Solution")
                    .font(.largeTitle).bold()
                .multilineTextAlignment(.center)
                    .padding()
                Text("Use GPT, an AI model to intelligently suggest complete sentences from a few keystrokes among other keyboard customizations.")
                    .font(.subheadline)
                .multilineTextAlignment(.center)
                    .opacity(0.7)
                    .padding()
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
                            .foregroundColor(Color(.systemPink))
                            .padding()
                            
                            .frame(height: 85)
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            
                            .multilineTextAlignment(.center)
                            
                    
                    
                    
                } .padding(.bottom)
                   
                }  .transition(.opacity)
                }
            }
        }   .opacity(dismiss ? 0 : 1)
    }
}

struct Ob4: View {
    @Binding var next: Int
    @State var animate: Bool = false
    @State var animate2: Bool = false
    @State var dismiss: Bool = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
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
                Text("Calibrate Proxima")
                    .font(.title)
                .multilineTextAlignment(.center)
                    .padding()
                Text("Scan for devices so Proxima can recognize the devices normally around you so Proxima can alert you of unfamiliar devices.")
                    .font(.subheadline)
                    .padding()
                .multilineTextAlignment(.center)
                    .opacity(0.7)
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
                            .foregroundColor(Color(.systemBlue))
                            .padding()
                            
                            .frame(height: 85)
                        Text("Calibrate")
                            .font(.headline)
                            .foregroundColor(.white)
                            
                            .multilineTextAlignment(.center)
                            
                    
                    
                    
                } .padding(.bottom)
                   
                }  .transition(.opacity)
                }
            }
        }   .opacity(dismiss ? 0 : 1)
    }
}
