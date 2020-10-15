//
//  CalibrateView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI

struct CalibrateView: View {
    @Binding var wait: Bool
    @State var calibrate: Bool = false
    
    @Binding var time: Double
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @ObservedObject var motionManager = MotionManager()
    
    @Binding var averageZ: Double
    
    @State var keysMistyped = [Double]()
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                Spacer()
                Text("Calibrate Your Keyboard")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Hold your phone in the position you normally do.  When finished if you tremor when tapping on a key the keyboard will zoom in on the section of the keyboard you tapped.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Button(action:{
                    
                        calibrate.toggle()
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 60)
                            .foregroundColor(Color(.systemPink))
                        Text("Calibrate")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
               
                Spacer()
            } .padding()
            
            if calibrate {
                Color(.white)
                Text("Hold your phone in the position you normally do until this message disappears.")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
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
                        if time > 5 {
                            if time < 6 {
                            print("ready")
                                wait = false
                            let sumArray = z.reduce(0, +)

                            averageZ = sumArray / Double(z.count)
                            
                            
                        }
                        }
                    }
                }
            }
        }
    }
}

