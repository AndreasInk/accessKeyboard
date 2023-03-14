//
//  Keyboard.swift
//  AIKeyboard
//
//  Created by Andreas Ink on 3/13/23.
//

import SwiftUI


struct KeyboardView: View {
    var viewController: KeyboardViewController
    @State var keyMistyped: Int = 0
    @State var step: Int = 0
   
    @State var averageZ = 0.0
    

    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "w", "e", "r", "t", "y","u", "i", "o", "p" ]).map { "\($0)" }
    @State var horizontal2 = (["a", "s", "d", "f", "g", "h", "j", "k", "l"]).map { "\($0)" }
    @State var horizontal3 = (["z", "x", "c", "v", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
   @State var columns = [GridItem]()
    var columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State var keyTime = [Double]()
    
    @State var suggestions = [String]()
    
    @State var isKeyboardOpen: Bool = true
    
    @State var keyNum: Int = 0
    @State var keyNum2: Int = 0
    @State var keysMistyped: [Double] = []
    @State var time: Double = 0.0
    @State var timeOn: Bool = false
    @State var keysMistyped2: [String] = []
    @State var counter: Int = 0
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Material.thick)
                .onAppear() {
                   
                    if screenSize.height > 812 {
                        self.columns = [GridItem(.adaptive(minimum: 35))]
                        
                        
                    } else {
                        self.columns =  [GridItem(.adaptive(minimum: 30))]
                    }
                }
            
                .onDisappear() {
                    columns.removeAll()
                    
                }
                .onTapGesture {
                    isKeyboardOpen = false
                    text = "Type Here"
                }
            
            
            
            
            
            
            VStack(alignment: .center) {
                //
                
                ZStack(alignment: .bottom) {
                    
                    
                    
                    VStack(alignment: .center) {
                        SuggestionsView(viewController: viewController, text: $text, suggestions: suggestions)
                        Spacer()
                        KeyboardRow2(viewController: viewController, data: horizontal1, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, counter: $counter)
                        
                        KeyboardRow2(viewController: viewController, data: horizontal2, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, counter: $counter)
                        KeyboardRow2(viewController: viewController, data: horizontal3, keyNum: $keyNum, keyNum2: $keyNum2, text: $text, keysMistyped: $keysMistyped, time: $time, timeOn: $timeOn, keysMistyped2: $keysMistyped2, counter: $counter)
                        
                        Spacer()
                    }
                    
                    .padding(.bottom, 50)
                    Button(action: {
                        text += " "
                       
                        keyNum2 += 1
                        keyNum += 1
                    }) {
                        Color(.white)
                            .frame(width: screenSize.width/1.1, height: 50)
                        
                            .padding(.bottom, 22)
                        
                    }
                }
                
            }
        }
        
        .onChange(of: text) { newValue in
            if let text = text.last {
                
                Task {
                    do {
                        suggestions = try await MagicManager.generateSuggestions(self.text)
                        
                    } catch {
                        
                    }
                }
            }
        }
    }
}

public enum ButtonState {
    case pressed
    case notPressed
}

/// ViewModifier allows us to get a view, then modify it and return it
public struct TouchDownUpEventModifier: ViewModifier {
    
    /// Properties marked with `@GestureState` automatically resets when the gesture ends/is cancelled
    /// for example, once the finger lifts up, this will reset to false
    /// this functionality is handled inside the `.updating` modifier
    @GestureState private var isPressed = false
    
    /// this is the closure that will get passed around.
    /// we will update the ButtonState every time your finger touches down or up.
    let changeState: (ButtonState) -> Void
    
    /// a required function for ViewModifier.
    /// content is the body content of the caller view
    public func body(content: Content) -> some View {
        
        /// declare the drag gesture
        let drag = TapGesture()
        
        /// this is called whenever the gesture is happening
        /// because we do this on a `DragGesture`, this is called when the finger is down
            .updating($isPressed) { (value, gestureState, transaction) in
                
                /// setting the gestureState will automatically set `$isPressed`
                gestureState = true
            }
        
        return content
            .gesture(drag) /// add the gesture
            .onChange(of: isPressed, perform: { (pressed) in /// call `changeState` whenever the state changes
                /// `onChange` is available in iOS 14 and higher.
                if pressed {
                    self.changeState(.pressed)
                    
                    
                } else {
                    self.changeState(.notPressed)
                }
            })
    }
    
    /// if you're on iPad Swift Playgrounds and you put all of this code in a seperate file,
    /// you need to add a public init so that the compiler detects it.
    public init(changeState: @escaping (ButtonState) -> Void) {
        self.changeState = changeState
    }
}
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
