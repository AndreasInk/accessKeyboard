//
//  Survey.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI

struct Survey: View {
    @State var next: Int = 0
    
    @State var isIntroducing: Bool = false
    @State var hasIntroed: Bool = false
    @State var complete: Bool = false
    @State var animate: Bool = false
    @EnvironmentObject var userData: UserData
    @State var surveyData = SurveyData(id: UUID().uuidString, questions: ["How would you rate your overall experience with this app?", "How would you rate your experience with the first keyboard?", "How would you rate your experience with the second/zoom keyboard?"], ratings: [0])
    @State var keys = Keys(id: UUID().uuidString, key: "",count: -1)
    var body: some View {
        ZStack {
            Color(.white)
            
            if next > 5 {
                ResultsView()
                
            } else {
                SurveyQuestion(next: $next)
            }
        }
    }
}
