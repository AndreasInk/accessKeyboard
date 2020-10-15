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
    @State var keys = [Keys]()
    @State var keyStrings = [String]()
    @State var keyStrings2 = [String]()
    @State var keyStringsCount = [Int]()
    var body: some View {
        ZStack {
        
            Color(.white)
                .onAppear() {
                    //getItems2()
                    getItems()
                    
                   
                  
                    
                    
                    
                }
            if hasThanked {
            if hasData {
                
                ScrollView {
                    VStack {
                    
                        
                
                        BarChartView(data: ChartData(values: [(keyStrings2[0], keyStringsCount[0]), (keyStrings2[1], keyStringsCount[1]), (keyStrings2[2], keyStringsCount[2])]), title: "Mistyped Keys", legend: "Quarterly", form: CGSize(width: 320, height: 320))
                            .padding()
                        Text("Below are some of the community's accuracy data, the orange lines are the community's mistaps and the other lines are the x, y, and z accelerations")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                        ForEach(data){ data in
                            
                           // Text("Time: \(data.time)")
                               // .font(.subheadline)
                          //  Text("Type: \(data.type)")
                             //   .font(.subheadline)
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
      
        db.collection("interactions")
            .limit(to: 4).whereField("type", isEqualTo: "Reg").getDocuments { (documents, error) in
            if documents?.count ?? -1 > -1 {
            for document in documents!.documents{
                print("add")
                data.append(IndividualData(id: document.get("id") as! String, x: document.get("x") as! [Double], y: document.get("y") as! [Double], z: document.get("z") as! [Double], keysMistyped: document.get("keysMistyped") as! [Double], time: document.get("time") as! Double, type: document.get("type") as! String, keysMistyped2: document.get("keysMistyped2") as! [String]))
                for data in data {
                    print(data)
                    for key in data.keysMistyped2 {
                        
                       
                        keyStrings.append(key)
                    }
                }
                        if self.data.count == documents?.count ?? -1 {
                            let sortedDictByValue = keyStrings.freq().sorted{ $0.value > $1.value }
                            print("sorted" + "\(sortedDictByValue)")
                            print(keyStrings.freq().sorted { $0.1 < $1.1 })
                            for key in sortedDictByValue {
                                keyStrings2.append(key.key)
                        
                            
                                keyStringsCount.append(key.value)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                hasData = true
                                }
                        }
                           
                        
                        }
                    print(keyStrings.freq())
                   
              
                
            }
               
               
            }
            }
            
        }
    func getItems2() {
        
        
        let db = Firestore.firestore()
      
        db.collection("interactions")
            .limit(to: 2).whereField("type", isEqualTo: "Zoom").getDocuments { (documents, error) in
            if documents?.count ?? -1 > -1 {
            for document in documents!.documents{
                print("add")
                data.append(IndividualData(id: document.get("id") as! String, x: document.get("x") as! [Double], y: document.get("y") as! [Double], z: document.get("z") as! [Double], keysMistyped: document.get("keysMistyped") as! [Double], time: document.get("time") as! Double, type: document.get("type") as! String, keysMistyped2: document.get("keysMistyped2") as! [String]))
                for data in data {
                    print(data)
                    for key in data.keysMistyped2 {
                        
                       
                        keyStrings.append(key)
                    }
                }
                        if self.data.count == documents?.count ?? -1 {
                            let sortedDictByValue = keyStrings.freq().sorted{ $0.value > $1.value }
                            print("sorted" + "\(sortedDictByValue)")
                            print(keyStrings.freq().sorted { $0.1 < $1.1 })
                            for key in sortedDictByValue {
                                keyStrings2.append(key.key)
                        
                            
                                keyStringsCount.append(key.value)
                        }
                           
                        
                        }
                    print(keyStrings.freq())
                   
                    
                
            }
               
               
            }
            }
            
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
