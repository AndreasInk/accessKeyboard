//
//  IndividualData.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//
import SwiftUI

struct IndividualData: Identifiable, Codable, Hashable  {
    var id: String
    var x: [Double]
    var y: [Double]
    var z: [Double]
    var keysMistyped: [Double]
    var time: Double
    var type: String
    var keysMistyped2: [String]
}
