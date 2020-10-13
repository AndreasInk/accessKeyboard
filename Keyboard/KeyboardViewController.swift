//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Andreas Ink on 10/3/20.
//

import UIKit
import SwiftUI
class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var zoomed: Bool = false
    var text: String = ""
    var key: String = ""

       weak var delegate: KeyboardViewControllerDelegate?
    var userLexicon: UILexicon?
    var currentWord: String? {
      var lastWord: String?
      if let stringBeforeCursor = textDocumentProxy.documentContextBeforeInput {
        stringBeforeCursor.enumerateSubstrings(in: stringBeforeCursor.startIndex...,
                                               options: .byWords)
        { word, _, _, _ in
          if let word = word {
            lastWord = word
          }
        }
      }
      return lastWord
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Get the currently selected text
        let selectedText = textDocumentProxy.selectedText
        print()

        // Perform custom UI setup here
        let child = UIHostingController(rootView: Keyboard(zoomed: zoomed, text: text, key: key))
          //that's wrong, it must be true to make flexible constraints work
         // child.translatesAutoresizingMaskIntoConstraints = false
        
          child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          view.addSubview(child.view)
          addChild(child)//not sure what is this for, it works without it.
    }
    
    override func viewWillLayoutSubviews() {
       // self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    func insertCharacter(_ newCharacter: String) {
      if key == " " {
       
        textDocumentProxy.insertText(newCharacter)
        }
      }

     
  
    override func textWillChange(_ textInput: UITextInput?) {
        let defaults = UserDefaults.standard
     
        textDocumentProxy.insertText(key)
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
       // self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
   
}
protocol KeyboardViewControllerDelegate: AnyObject {
    func update(_ key: String)

}
struct SwiftUIButton: View{
    let action: () -> ()
    var body: some View{
        Button(action: action){Text("Tap me")}
    }
}
private extension KeyboardViewController {
  func attemptToReplaceCurrentWord() {
    guard let entries = userLexicon?.entries,
      let currentWord = currentWord?.lowercased() else {
        return
    }

    let replacementEntries = entries.filter {
      $0.userInput.lowercased() == currentWord
    }

    if let replacement = replacementEntries.first {
      for _ in 0..<currentWord.count {
        textDocumentProxy.deleteBackward()
      }

      textDocumentProxy.insertText(replacement.documentText)
    }
  }
}
