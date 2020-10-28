//
//  ResultsView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/14/20.
//

import SwiftUI
import Firebase
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
                .onAppear() {
                    //getItems2()
                    getItems()
                    
                   
                  
                    
                    
                    
                }
            if hasThanked {
            if hasData {
                
                ScrollView {
                    LazyVStack {
                    
                        
                
                       
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
            .limit(to: 20).whereField("keysMistyped", arrayContains: 0.5).getDocuments { (documents, error) in
            if documents?.count ?? -1 > -1 {
            for document in documents!.documents{
                print("add")
                
                data.append(IndividualData(id: document.get("id") as! String, x: document.get("x") as! [Double], y: document.get("y") as! [Double], z: document.get("z") as! [Double], keysMistyped: document.get("keysMistyped") as! [Double], time: document.get("time") as! Double, type: document.get("type") as! String, keysMistyped2: document.get("keysMistyped2") as! [String]))
                for data in data {
                  //  print(data)
                    for key in data.keysMistyped2 {
                        
                       
                        keyStrings.append(key)
                        
                        
                    }
                   
                }
                let startNumber = 0
                let middleNumber = 200
                let middleNumber2 = 300
                let endNumber = 400
                let numberRange = startNumber...middleNumber
                let numberRange2 = middleNumber2...endNumber
                for index in 0..<self.data.count {
                    let avg1 = average(of: data[index].z[0...data[index].x.count - 1])
                    print("average z " + "\(avg1)")
                   
                    for index2 in 0..<self.data[index].keysMistyped.count {
                        if  data[index].keysMistyped[index2] == 0.5 {
                            data[index].keysMistyped[index2] = -0.5
                           // print("Mistype z: " + "\(data[index].z[index2])")
                        }
                        if  data[index].keysMistyped[index2] == 0.0 {
                            data[index].keysMistyped[index2] = -1
                        }
                      
                    }
                    for index2 in 0..<self.data[index].z.count {
                       
                       
                        //data[index].z[index2] =  data[index].z[index2] + 0.15
                       
                   // for index2 in 0..<self.data[index].y.count {
                       
                        //data[index].y[index2] =  data[index].y[index2] + 0.15
                       // if numberRange.contains(index2) {
                        //    data[index].y.remove(at: index2)
                       // }
                       // if numberRange2.contains(index2)  {
                       //     data[index].y.remove(at: index2)
                       // }
                 //   }
                   // for index2 in 0..<self.data[index].keysMistyped.count {
                       
                       // data[index].y[index2] =  data[index].y[index2] + 0.15
                      //  if numberRange.contains(index2) {
                           // data[index].keysMistyped.remove(at: index2)
                       // }
                      //  if numberRange2.contains(index2)  {
                      //      data[index].keysMistyped.remove(at: index2)
                      //  }
                        if self.data[index].z[index2] ==  -0.5419075012207031 {
                            print("Mistyped near 90% \(data[index].keysMistyped[index2 - 1])")
                            print("Mistyped near 90% \(data[index].keysMistyped[index2 + 1])")
                            print("Mistyped near 90% \(data[index].keysMistyped[index2 - 5])")
                            print("Mistyped near 90% \(data[index].keysMistyped[index2 + 5])")
                        }
                    }
                    print("Precentile value: " + "\(Sigma.percentile(data[index].z, percentile: 0.95))")
                    
                    
                   
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
               print(data)
              
             
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

