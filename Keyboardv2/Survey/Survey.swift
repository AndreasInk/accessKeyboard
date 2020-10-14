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
    @State var surveyData = [SurveyData]()
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    surveyData.append()
                }
        if next == 0 {
            SurveyQuestion(next: $next)
               
                
        } else if next == 1 {
            SurveyQuestion(next: $next)
                
        } else if next == 2 {
            SurveyQuestion(next: $next)
                
        }
        }
    }
}
