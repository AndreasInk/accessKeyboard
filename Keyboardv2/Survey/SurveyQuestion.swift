//
//  SurveyQuestion.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI

struct SurveyQuestion: View {
    @State var question: String = "How would you rate your overall experience with this app?"
    @State var hasSelected: Bool = false
    @Binding var next: Int
    @State private var row1 = [Row]()
    @State private var row2 = [Row]()
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    for counter in 0...3 {
                    row1.append(Row(id: UUID().uuidString, rating: counter, isRated: false))
                }
                    for counter in 3...6 {
                    row2.append(Row(id: UUID().uuidString, rating: counter, isRated: false))
                }
                }
        VStack {
            Text(question)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
        HStack {
            ForEach(row1){ number in
            Button(action:{
                
                withAnimation(.easeInOut(duration: 1.5)) {
                    row1[number.rating].isRated.toggle()
                    hasSelected.toggle()
                    
                }
                
            }) {
                ZStack {
                    
                    Circle()
                        .frame(height: 140)
                        .foregroundColor(Color( number.isRated ? .systemPink : .gray))
                    Text("\(number.rating)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            }
        } .padding()
            HStack {
                ForEach(row2){ number in
                Button(action:{
                    withAnimation() {
                        row2[number.rating].isRated.toggle()
                        hasSelected.toggle()
                    }
                        
                    
                }) {
                    ZStack {
                        
                        Circle()
                            .frame(height: 140)
                            .foregroundColor(Color( number.isRated ? .systemPink : .gray))
                        Text("\(number.rating)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                    
                }
            } .padding()
            
            if hasSelected {
            Button(action:{
                
                   next += 1
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(Color(.systemPink))
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            } .padding()
        }
        }
    }
    }
}

struct Survey_Previews: PreviewProvider {
    static var previews: some View {
        Survey()
    }
}
