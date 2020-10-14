//
//  terms.swift
//  Proxima.Ai
//
//  Created by Andreas Ink on 10/3/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct Terms: View {
    @Binding var next: Int
    @State var dismiss: Bool = false
    @State var animate: Bool = false
    @State var animate2: Bool = false
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
        }
        VStack {
           
            Text("Terms of Use")
                .font(.title)
                .animation(nil)
                .padding()
                .padding(.top, 110)
            ScrollView {
            Text("Proxima.Ai's intent is to help people protect themselves and their property.  Proxima.Ai and it's creators are not liable for any effects directly or indirectly occuring because of any alerts or lack of alerts sent to a user because of a possible intruder due to the detection of one or more unfamiliar device(s).  By pressing accept you agree to Proxima.Ai's Terms of Use.")
                .font(.body)
                .multilineTextAlignment(.center)
                .animation(nil)
                .padding()
            }
            
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
                    Text("Accept")
                        .font(.subheadline)
                        .foregroundColor(Color(.white))
                        
                        .multilineTextAlignment(.center)
                        
                
                
                }
            } .transition(.opacity)
            .padding(.bottom, 110)
        }
    }  .opacity(dismiss ? 0 : 1)
}
}
