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
    @State var surveyData = SurveyData(id: UUID().uuidString, questions: ["How would you rate your overall experience with this app?", "How would you rate your experience with the first keyboard?", "How would you rate your experience with the second/zoom keyboard?", "How helpful would a sensitivity setting be for the second/zoom keyboard?", "How much does your energy fluctuate throughout the day?","How helpful would time based sensitivity be for the second/zoom keyboard?"], ratings: [0])
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    for counter in 1...3 {
                        row1.append(Row(id: UUID().uuidString, rating: counter, isRated: false, num: counter - 1))
                }
                    for counter in 3...5 {
                        row2.append(Row(id: UUID().uuidString, rating: counter, isRated: false, num: counter - 3))
                }
                }
        VStack {
           
                Text(surveyData.questions[next])
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
            
        HStack {
            ForEach(row1){ number in
            Button(action:{
                
                withAnimation(.easeInOut(duration: 1)) {
                    row1[number.num].isRated.toggle()
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
                        row2[number.num].isRated.toggle()
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


