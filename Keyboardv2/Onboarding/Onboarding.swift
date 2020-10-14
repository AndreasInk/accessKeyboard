//
//  Onboarding.swift
//  Proxima.Ai
//
//  Created by Andreas Ink on 10/3/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct Onboarding: View {
    @State var next: Int = 0
    
    @State var isIntroducing: Bool = false
    @State var hasIntroed: Bool = false
    @State var complete: Bool = false
    @State var animate: Bool = false
    @EnvironmentObject var userData: UserData
    var body: some View {
        ZStack {
        
        if next == 0 {
            Ob1(next: $next)
                .padding(.bottom, 40)
                .onAppear() {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate.toggle()
                }
                }
        } else if next == 1 {
            Ob2(next: $next)
                .padding(.bottom, 40)
        } else if next == 2 {
            Ob3(next: $next)
                .padding(.bottom, 40)
                .onDisappear() {
                    userData.isOnboardingCompleted = true
                }
        }
                
            
      
            if animate {
            VStack {
                Spacer()
                ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 325, height: 25)
                    .foregroundColor(.white)
                    
                    .opacity(complete ? 0.0 : 1.0)
                    if next == 0 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 0, height: 15)
                        .foregroundColor(Color(.systemBlue))
                        .animation(.easeInOut)
                        .transition(.identity)
                        .onAppear() {
                            complete.toggle()
                        }
            }
                    if next == 1 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 162.5, height: 15)
                        .foregroundColor(Color(.systemPink))
                        .animation(.easeInOut)
                        .transition(.identity)
                        .onAppear() {
                            complete.toggle()
                        }
            }
                    if next == 2 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 325, height: 15)
                        .foregroundColor(Color(.systemPink))
                        .animation(.easeInOut)
                        .transition(.identity)
            }
                    if next == 3 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 243.75, height: 15)
                        .foregroundColor(Color(.systemPink))
                        .animation(.easeInOut)
                        .transition(.identity)
            }
                    if next == 4 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 325, height: 15)
                        .foregroundColor(Color(.systemPink))
                        .animation(.easeInOut)
                        .transition(.identity)
            }
                    if next == 5 {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 325, height: 15)
                        .foregroundColor(Color(.systemPink))
                        .animation(.easeInOut)
                        .transition(.identity)
                        .opacity(0.0)
                        .onAppear() {
                            complete.toggle()
                        }
            }
                } .padding(.bottom)
            } .transition(.opacity)
            }
    }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
