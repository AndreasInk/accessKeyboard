//
//  Admin.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/13/20.
//

import SwiftUI

struct Admin: View {
    @State var data = [IndividualData]()
    let screenSize = UIScreen.main.bounds
    var body: some View {
        ZStack {
            Color(.white)
               
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

}
struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
