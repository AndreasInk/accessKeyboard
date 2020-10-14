//
//  ChatData.swift
//  Keyboard
//
//  Created by Andreas Ink on 7/30/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI

struct ChatData: Identifiable, Hashable {
    
    var id: String
    
    var name: String
    
    var message: String
    
    var isMe: Bool
    
    var isView: Bool
    
    var viewMessage: String
    
    var viewTitle: String
    
     var step: Int
    
    init(id: String, name: String, message: String, isMe: Bool, isView: Bool, viewMessage: String, viewTitle: String, step: Int) {
        self.id = id
        self.name = name
        self.message = message
        self.isMe = isMe
        self.isView = isView
        self.viewTitle = viewTitle
        self.viewMessage = viewMessage
        self.step = step
    }
}
