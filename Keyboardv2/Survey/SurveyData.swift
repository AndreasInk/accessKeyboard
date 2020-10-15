//
//  SurveyData.swift
//  Keyboard
//
//  Created by Andreas Ink on 7/30/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct SurveyData: Identifiable  {
    var id: String
    var questions: [String]
    var ratings: [Int]
    
    
}
struct Row: Identifiable  {
    var id: String
    var rating: Int
    var isRated: Bool
    var num: Int
   
    
}

struct Keys: Identifiable, Hashable  {
    var id: String
    var key: String
    var count: Int
    
   
    
}
