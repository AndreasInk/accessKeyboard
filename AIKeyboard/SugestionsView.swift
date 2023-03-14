//
//  SugestionsView.swift
//  AIKeyboard
//
//  Created by Andreas Ink on 3/13/23.
//

import SwiftUI

struct SuggestionsView: View {
    var viewController: KeyboardViewController
    @Binding var text: String
    let suggestions: [String]
    var body: some View {
        VStack {
            ForEach(suggestions, id: \.self) { suggestion in
                Button {
                    text += suggestion
                    viewController.textDocumentProxy.insertText(String(text))
                } label: {
                    Text(suggestion)
                        .padding()
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.accentColor)
                        }
                }

            }
        }
    }
}
