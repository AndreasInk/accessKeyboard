//
//  IndividualData.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//
import SwiftUI

struct IndividualData: Identifiable, Codable {
    var id: UUID
    var x: [Double]
    var y: [Double]
    var z: [Double]
    var keysMistyped: [Double]
    var time: [Double]
    var type: String
}
