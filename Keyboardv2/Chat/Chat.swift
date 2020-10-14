//
//  Chat.swift
//  Keyboard
//
//  Created by Andreas Ink on 7/30/20.
//  Copyright © 2020 2020. All rights reserved.
//

import SwiftUI
import SwiftUICharts
struct ChatView: View {
    
    @State var chat = [ChatData(id: "\(UUID())", name: "Bot_Name", message: "Hey, I'm Bot_Name! What's your name?", isMe: false, isView: false, viewMessage: "", viewTitle: "", step: -1)]
    
    @EnvironmentObject var userData: UserData
    
    @State var currentOffset = 0
    
    @State var scrollOffset = 0
    
    @State var stepCount = -1
    
    @State var nextStep = false
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @Binding var keyTime: [Double]
    
    @Binding var isKeyboardOpen: Bool
    
    @Binding var didTap1: Bool
    
    @Binding var didTap2: Bool
    
    @Binding var text: String
    var body: some View {
        ZStack {
            Color(.white)
        VStack {
            
                Spacer()

          //  ReverseScrollView(scrollOffset: CGFloat(self.scrollOffset), currentOffset: CGFloat(self.currentOffset)) {
            ScrollView {
                        ScrollViewReader { value in
                            
                VStack {
                    
                    ForEach(self.userData.chat, id: \.id) { chatting in
                        
                        
                        
                        Group {
                          
                            
                            
                         
                       
                               
                            if chatting.isView {
                                VStack {
                                    if userData.chat.last?.viewTitle == "Allow ChatBot_Name to remember where you've tapped?" {
                                        ChatPermission2(title: chatting.viewTitle, message: chatting.viewMessage, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap2)
                                    } else if userData.chat.last?.viewTitle == "Allow ChatBot_Name to remember this conversation?" {
                                        ChatPermission(title: chatting.viewTitle, message: chatting.viewMessage, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap2, text: $text)
                                    } else if userData.chat.last?.viewTitle == "Try out demo keyboards?" {
                                        ChatPermission3(title: chatting.viewTitle, message: chatting.viewMessage, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap2)
                                    } else {
                                    ChatV2Cell2(name: chatting.name, message: chatting.message)
                                        .id(chatting)
                                    
                                        ChatPermission(title: chatting.viewTitle, message: chatting.viewMessage, isKeyboardOpen: $isKeyboardOpen, didTap1: $didTap1, didTap2: $didTap2, text: $text)
                                        
                                   // MultiLineChartView(data: [(x, GradientColors.green), (y, GradientColors.purple), (z, GradientColors.orngPink), (keyTime, GradientColors.blu)], title: "X: g, Y: p, Z: o, keys: b")
                                    
                                  //  LineChartView(data: z, title: "Title", legend: "Legendary")
                                }
                                }
                            } else {
                            if !chatting.isMe {
                                HStack {
                                    ChatV2Cell2(name: chatting.name, message: chatting.message)
                                        .id(chatting)
                                   Spacer()
                                }
                                
                            }
                            if chatting.isMe {
                                HStack {
                                    Spacer()
                                    ChatV2Cell(name: chatting.name, message: chatting.message)
                                        .id(chatting)
                                }
                                
                                    }

                            }
                        }
                        .onAppear() {
                            self.stepCount += 1
                          //  print(stepCount)
                           
                                
                            value.scrollTo(chatting, anchor: .top)
                        
                            
                        }
                        
                       
                        }
                    
                        } 
                }
                }
            
            
        } 
        
            
    }
    }
    }




struct ReverseScrollView<Content>: View where Content: View {
    @State private var contentHeight: CGFloat = CGFloat.zero
    @State  var scrollOffset: CGFloat = CGFloat.zero
    @State var currentOffset: CGFloat = CGFloat.zero
    @State var hasPressedUp = false
    @State var topLimit = CGFloat(0)
    @State var test = false
    var content: () -> Content
    
    // Calculate content offset
    func offset(outerheight: CGFloat, innerheight: CGFloat) -> CGFloat {
        print("outerheight: \(outerheight) innerheight: \(innerheight)")
        
        let totalOffset = currentOffset + scrollOffset
        return -((innerheight/2 - outerheight/2) - totalOffset)
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            // Render the content
            //  ... and set its sizing inside the parent
            self.content()
                .modifier(ViewHeightKey())
                .onPreferenceChange(ViewHeightKey.self) { self.contentHeight = $0 }
                .frame(height: outerGeometry.size.height)
                .offset(y: self.offset(outerheight: outerGeometry.size.height, innerheight: self.contentHeight))
                .clipped()
                .animation(.easeInOut)
                .gesture(
                    DragGesture()
                        .onChanged({ self.onDragChanged($0) })
                        .onEnded({ self.onDragEnded($0, outerHeight: outerGeometry.size.height)}))
            
            VStack {
                HStack {
                    Spacer()
                     if self.contentHeight > 530 {
                        if test {
                        Text("Scroll up")
                            .foregroundColor(.black)
                            .padding()
                            .background(BlurView(style: .extraLight)).clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            .onTapGesture {
                                print("scroll up")
                                let scrollOffset = self.scrollOffset + 60
                                print("Ended currentOffset=\(self.currentOffset) scrollOffset=\(scrollOffset)")
                                
                                self.topLimit = CGFloat(Int(self.contentHeight - outerGeometry.size.height))
                                print("toplimit: \(self.topLimit)")
                                
                                // Negative topLimit => Content is smaller than screen size. We reset the scroll position on drag end:
                                if self.topLimit < 0 {
                                    self.currentOffset = 0
                                } else {
                                    // We cannot pass bottom limit (negative scroll)
                                    if self.currentOffset + scrollOffset < 0 {
                                        self.currentOffset = 0
                                    } else if self.currentOffset + scrollOffset > self.topLimit {
                                        self.currentOffset = CGFloat(self.topLimit)
                                    } else {
                                        self.currentOffset += scrollOffset
                                    }
                                }
                                print("new currentOffset=\(self.currentOffset)")
                                self.scrollOffset = 0
                        }
                        }
                     }
                    
                    Spacer()
                    
                    
                } .padding(.vertical, 22)
                
                Spacer(minLength: 300)
                HStack {
                    Spacer()
                    if self.currentOffset >= 30 {
                        if test {
                        Text("Scroll down")
                            .foregroundColor(.black)
                            .padding()
                            
                            .background(BlurView(style: .extraLight)).clipShape(RoundedRectangle(cornerRadius: 10))
                        .zIndex(1)
                            .padding(.bottom, 22)
                            .onTapGesture {
                                print("scroll down")
                                let scrollOffset = self.scrollOffset - 80
                                print("Ended currentOffset=\(self.currentOffset) scrollOffset=\(scrollOffset)")
                                
                                let topLimit = self.contentHeight - outerGeometry.size.height
                                print("toplimit: \(topLimit)")
                                self.topLimit = self.contentHeight - outerGeometry.size.height
                                print("toplimit: \(topLimit)")
                                // Negative topLimit => Content is smaller than screen size. We reset the scroll position on drag end:
                                if self.topLimit < 0 {
                                    self.currentOffset = 0
                                } else {
                                    // We cannot pass bottom limit (negative scroll)
                                    if self.currentOffset + scrollOffset < 0 {
                                        self.currentOffset = 0
                                    } else if self.currentOffset + scrollOffset > topLimit {
                                        self.currentOffset = topLimit
                                    } else {
                                        self.currentOffset += scrollOffset
                                    }
                                }
                                print("new currentOffset=\(self.currentOffset)")
                                self.scrollOffset = 0
                        }
                    }
                    }
                    Spacer()
                }
                Spacer()
            }.padding(.vertical, 22)
        }
    }
    
    func onDragChanged(_ value: DragGesture.Value) {
        // Update rendered offset
        print("Start: \(value.startLocation.y)")
        print("Start: \(value.location.y)")
        self.scrollOffset = (value.location.y - value.startLocation.y)
        print("Scrolloffset: \(self.scrollOffset)")
    }
    
    func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
        // Update view to target position based on drag position
        let scrollOffset = value.location.y - value.startLocation.y
        print("Ended currentOffset=\(self.currentOffset) scrollOffset=\(scrollOffset)")
        
        let topLimit = self.contentHeight - outerHeight
        print("toplimit: \(topLimit)")
        
        // Negative topLimit => Content is smaller than screen size. We reset the scroll position on drag end:
        if topLimit < 0 {
            self.currentOffset = 0
        } else {
            // We cannot pass bottom limit (negative scroll)
            if self.currentOffset + scrollOffset < 0 {
                self.currentOffset = 0
            } else if self.currentOffset + scrollOffset > topLimit {
                self.currentOffset = topLimit
            } else {
                self.currentOffset += scrollOffset
            }
        }
        print("new currentOffset=\(self.currentOffset)")
        self.scrollOffset = 0
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

