//
//  KeyboardViewController.swift
//  AIKeyboard
//
//  Created by Andreas Ink on 3/13/23.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let child = UIHostingController(rootView: KeyboardView(viewController: self))
        //that's wrong, it must be true to make flexible constraints work
        // child.translatesAutoresizingMaskIntoConstraints = false
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(child.view)
        
        addChild(child)
    }
    
    override func viewWillLayoutSubviews() {
       
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
      
    }

}
