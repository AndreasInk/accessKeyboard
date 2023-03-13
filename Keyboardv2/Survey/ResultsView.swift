//
//  ResultsView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI

import SigmaSwiftStatistics
struct ResultsView: View {
    @State var data = [IndividualData]()
    @State var hasData: Bool = false
    @State var hasThanked: Bool = false
    @State var keys = [Keys]()
    @State var keyStrings = [String]()
    @State var keyStrings2 = [String]()
    @State var keyStringsCount = [Int]()
    var body: some View {
        ZStack {
        
            Color(.white)
               
            if hasThanked {
            if hasData {
                
                ScrollView {
                    LazyVStack {
                        
                        Text("Below are some of the community's accuracy data, the orange lines are the community's mistaps and the other lines are the x, y, and z accelerations")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                        ForEach(data){ data in
                    
                            MultiLineChartView(data: [(data.x, GradientColors.green), (data.keysMistyped, GradientColors.orngPink)], title: "X Acceleration")
                                .padding()
                            MultiLineChartView(data: [(data.y, GradientColors.blu), (data.keysMistyped, GradientColors.orngPink)], title: "Y Acceleration")
                                .padding()
                            MultiLineChartView(data: [(data.z, GradientColors.purple), (data.keysMistyped, GradientColors.orngPink)], title: "Z Acceleration")
                                .padding()
                            
                            
                            Divider()
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
            }
                }
            } else {
                Text("Insufficient data")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            } else {
                VStack {
                Text("Thank You!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    Text("We are using your contribution to build a digital keyboard to help people with issues typing communicate more easily")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
                        withAnimation() {
                            hasThanked.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.systemPink))
                                .padding()
                                
                                .frame(height: 85)
                            Text("See Data")
                                .font(.headline)
                                .foregroundColor(Color(.white))
                               
                                
                                .multilineTextAlignment(.center)
                                
                        
                        
                        
                    }
                       
                    }
            }
            }
        }
    }

    func average<C: Collection>(of c: C) -> Double where C.Element == Double {
        precondition(!c.isEmpty, "Cannot compute average of empty collection")
        return Double(c.reduce(0, +))/Double(c.count)
    }
    }


extension Sequence where Self.Iterator.Element: Hashable {
     typealias Element = Self.Iterator.Element

    func freq() -> [Element: Int] {
        return reduce([:]) { (accu: [Element: Int], element) in
            var accu = accu
            accu[element] = accu[element]?.advanced(by: 1) ?? 1
            return accu
        }
    }
}

