//
//  ChatCells.swift
//  Keyboard
//
//  Created by Andreas Ink on 7/30/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct ChatV2Cell: View {
    
    @State var name = ""
    
    @State var message = ""
    
    var body: some View {
        
        
        ZStack(alignment: .leading) {
            
            Color(.white)
                .frame(minWidth: 370 ,maxWidth: .infinity).frame(minWidth: 370 ,maxWidth: .infinity)
                .edgesIgnoringSafeArea(.horizontal)
            HStack {
                Spacer()
                
                Text(message)
                    .foregroundColor(.white)
                    .lineLimit(.none)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    .padding(12)
                    .background(Color(.systemPink))
                    .cornerRadius(10)
                
                
            } .padding(.trailing, 12)
        } 
         
        
        
    }
}
struct ChatV2Cell2: View {
    @State var name = ""
    @State var message = ""
    var body: some View {
        ZStack(alignment: .trailing) {
            
            Color(.white)
                .frame(minWidth: 370 ,maxWidth: .infinity)
                .edgesIgnoringSafeArea(.horizontal)
            HStack() {
                
                ScrollView {
                Text(message)
                    .foregroundColor(.white)
                    .lineLimit(.none)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(12)
                    .background(Color(.gray))
                    .cornerRadius(10)
                }
                Spacer()
            } .padding(.leading, 12)
        }
            
           
        
    }
}
