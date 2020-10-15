//
//  ResultsView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import Firebase

struct ResultsView: View {
    @State var data = [IndividualData]()
    @State var hasData: Bool = false
    @State var hasThanked: Bool = false
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    getItems()
                    hasData = true
                }
            if hasThanked {
            if hasData {
                
                ScrollView {
                    VStack {
                    
                        
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
        }
            } else {
                VStack {
                Text("Thank You!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    Text("We are using your contribution to build a digital keyboard to help people with neurological diseases communicate more easily")
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
    
    func getItems() {
        
        
        let db = Firestore.firestore()
      
        db.collection("interactions").whereField("keysMistyped", arrayContains: 0.5)
            .limit(to: 10).getDocuments { (documents, error) in
            if documents?.count ?? -1 > -1 {
            for document in documents!.documents{
                data.append(IndividualData(id: document.get("id") as! String, x: document.get("x") as! [Double], y: document.get("y") as! [Double], z: document.get("z") as! [Double], keysMistyped: document.get("keysMistyped") as! [Double], time: 0.0, type: document.get("type") as! String, keysMistyped2: document.get("keysMistyped2") as! [String]))
                
            }
            }
            
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
