//
//  KeyboardRowView.swift
//  AIKeyboard
//
//  Created by Andreas Ink on 3/13/23.
//

import SwiftUI

struct KeyboardRow2: View {
    var viewController: KeyboardViewController
    @State var data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @Binding var keyNum: Int
    @Binding var keyNum2: Int
    let screenSize = UIScreen.main.bounds
    @Binding var text: String
    @Binding var keysMistyped: [Double]
    @Binding var time: Double
    @Binding var timeOn: Bool
    @Binding var keysMistyped2: [String]

    @Binding var counter: Int
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack() {
            
      
            ForEach(data, id: \.self) { item in
             //Spacer()
                Button(action: {
                    timeOn = true
                   
                     if item == "backspace" {
                         viewController.textDocumentProxy.deleteBackward()
                         let oldText = text
                         text = text.replacingOccurrences(of: viewController.textDocumentProxy.selectedText ?? "", with: "")
                         if oldText == text {
                             if text.count > 1 {
                                 text.removeLast()
                             }
                         }
                     } else {
                         viewController.textDocumentProxy.insertText(String(item))
                         text += item
                     }
                     
                }) {
                   
                ZStack(alignment: .center) {
                    
                    if item != "backspace" {
                        if item != "space" {
                            Color(.white)
                                .frame(minWidth: 20, idealWidth: 30, maxWidth: 30, minHeight: 35, idealHeight: 45, maxHeight: 45, alignment: .center)
                            Text(item)
                                .font(.headline)
                               // .padding(5)
                               // .background(Color.white)
                                 
                        .foregroundColor(.black)
                        }
                    }
                    if item == "backspace" {
                        ZStack {
                       
                            Image(systemName: "delete.backward.fill")
                                .resizable()
                                .scaledToFill()
                               
                            .frame(width: 40, height: 30, alignment: .center)
                            .padding(.trailing)
                               // .background(Color(.white))
                    }
                    }
                }
                }
                
            
            
            
           
        }
    }
}

}
