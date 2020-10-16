//
//  Admin.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI

import Firebase
struct Admin: View {
    @State var data = [IndividualData]()
    let screenSize = UIScreen.main.bounds
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    getItems()
                }
            ScrollView(.horizontal) {
               
        HStack {
            ForEach(data){ user in
                Spacer(minLength: screenSize.width/2)
                ChartView(x: user.x, y: user.y, z: user.z, keysMistyped: user.keysMistyped)
                Spacer(minLength: screenSize.width/2)
                Divider()
            }
        }
        }
    }
    }
    func getItems() {

       
        let db = Firestore.firestore()
      
        db.collection("interactions").getDocuments { (documents, error) in
            if documents?.count ?? -1 > -1 {
            for document in documents!.documents{
                data.append(IndividualData(id: document.get("id") as! String, x: document.get("x") as! [Double], y: document.get("y") as! [Double], z: document.get("z") as! [Double], keysMistyped: document.get("keysMistyped") as! [Double], time: 0.0, type: document.get("type") as! String, keysMistyped2: document.get("keysMistyped2") as! [String]))
                
            }
            }
        }
    }

}
struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
