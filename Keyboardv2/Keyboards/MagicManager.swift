//
//  MagicManager.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 3/13/23.
//

import SwiftUI
import OpenAIKit
class MagicManager {
    
    
    static func generateSuggestions(_ text: String) async throws -> [String] {
        let prompt = "Finish the following text message\n \(text)"
       
        let config = Configuration(
            organizationId: APIKey.orgID,
            apiKey: APIKey.apiKey
        )
        
        let openAI = OpenAI(config)
        var messages = [ChatMessage(role: .system, content: "You are a backend endpoint that finishes a short text message sent from a friend given a few characters")]
        messages.append(ChatMessage(role: .user, content: prompt))
        let chatParameters = ChatParameters(model: "gpt-3.5-turbo", messages: messages)
        let response = try await openAI.generateChatCompletion(parameters: chatParameters)
        let options = response.choices.map{$0.message}
        print(options)
        return options.map { $0.content }
    }
}
