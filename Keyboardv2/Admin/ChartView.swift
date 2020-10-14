//
//  ChartView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI
import SwiftUICharts
struct ChartView: View {
    @State var x = [Double]()
    
    @State var y = [Double]()
    
    @State var z = [Double]()
    
    @State var keysMistyped = [Double]()
    
    var body: some View {
        HStack {
        MultiLineChartView(data: [(x, GradientColors.green), (keysMistyped, GradientColors.purple)], title: "X")
            MultiLineChartView(data: [(y, GradientColors.blu), (keysMistyped, GradientColors.purple)], title: "Y")
            MultiLineChartView(data: [(z, GradientColors.orngPink), (keysMistyped, GradientColors.purple)], title: "Z")
    }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
