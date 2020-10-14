//
//  Admin.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI
import SwiftUICharts
struct Admin: View {
    @State var data = [IndividualData]()
    
    var body: some View {
        ZStack {
            Color(.white)
                .onAppear() {
                    self.loadData(){ userData in
                        //Get completion handler data results from loadData function and set it as the recentPeople local variable
                        data = userData
                        
                    }
                }
        ScrollView {
        HStack {
            ForEach(data){ user in
                ChartView(x: user.x, y: user.y, z: user.z, keysMistyped: user.keysMistyped)
            }
        }
        }
    }
    }
    func loadData(performAction: @escaping ([IndividualData]) -> Void){
        let db = Firestore.firestore()
        let docRef = db.collection("groups")
        var userList:[IndividualData] = []
        //Get every single document under collection users
        let queryParameter = docRef//.whereField("members", arrayContains: userData.userID)
        queryParameter.getDocuments{ (querySnapshot, error) in
            for document in querySnapshot!.documents{
                let result = Result {
                    try document.data(as: IndividualData.self)
                }
                switch result {
                    case .success(let user):
                        if let user = user {
                            userList.append(user)
                 
                        } else {
                            
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                    }
                
              
            }
              performAction(userList)
        }
        
        
    }
}

struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
