//
//  ChatPermission4.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import CoreMotion

struct ChatPermission4: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var title = ""
    
    @State var message = ""
    
    @State var action = ""
    
   
    @Binding var isKeyboardOpen: Bool
   
    let motionManager = CMMotionManager()
    @State var didTap1: Bool = false
    
    @State var didTap2: Bool = false
    var body: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
            VStack(alignment: .leading) {
             
                Text(title)
                    .font(.headline).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
              
                Text(message)
                    .font(.body).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                HStack {
                    
                    Button(action: {
                       
                     
                    
                     
                       
                            userData.survey = true
                        
                        didTap1.toggle()
                    }) {
                        ZStack {
                            Color(didTap1  ? .systemPink : .white)
                            Text("Yes")
                                .foregroundColor(didTap1  ? .white : .black)
                                .fontWeight(.bold)
                        }
                    } .frame(height: 50)
                    Button(action: {
                        didTap2.toggle()
                        userData.demoKeyboards = false
                        isKeyboardOpen = false
                        self.userData.step =  self.userData.step + 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.userData.chat.append(ChatData(id: "\(UUID())", name: "Bot_Name", message: "Thank you for helping us make a difference!", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: 1))
                        }
                    }) {
                        ZStack {
                            Color( didTap2 ? .systemPink : .white)
                            Text("No")
                                .foregroundColor( didTap2 ? .white : .black)
                                .fontWeight(.bold)
                            
                           
                        }
                    } .frame(height: 50)
                }
            }
        } .padding(12)
            .frame(height: 300)
    }
}

