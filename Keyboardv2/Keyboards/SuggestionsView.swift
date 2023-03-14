//
//  SuggestionsView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 3/13/23.
//

import SwiftUI

struct SuggestionsView: View {
    @Binding var text: String
    let suggestions: [String]
    var body: some View {
        VStack {
            ForEach(suggestions, id: \.self) { suggestion in
                Button {
                    text += suggestion
                } label: {
                    Text(suggestion)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.thinMaterial)
                        }
                }

            }
        }
    }
}
