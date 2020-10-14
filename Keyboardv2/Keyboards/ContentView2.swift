//
//  ContentView.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/3/20.
//

import SwiftUI
import CoreMotion
struct ContentView2: View {
    @EnvironmentObject var userData: UserData
    
    let data = (["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "backspace"]).map { "\($0)" }
    @State var horizontal1 = (["q", "p", "l", "w", "a", "z","e", "s", "x" ]).map { "\($0)" }
    @State var horizontal2 = (["r", "d", "c", "t", "f", "v", "y", "g", "b"]).map { "\($0)" }
    @State var horizontal3 = (["u", "h", "n", "i", "j", "m", "o", "k", "backspace"]).map { "\($0)" }
    let screenSize = UIScreen.main.bounds
    let columns = [
        GridItem(.adaptive(minimum: 30))
    ]
    let columns1 = [
        GridItem(.adaptive(minimum: 80))
    ]
    @Binding var zoomed: Bool
    @State var zoom1: Bool = false
    @State var zoom2: Bool = false
    @State var zoom3: Bool = false
    @Binding var text: String
    @Binding var key: String 
    @State var time: Double = 0.0
    
    @Binding var x: [Double]
    
    @Binding var y: [Double]
    
    @Binding var z: [Double]
    
    @Binding var keysTime: [Double]
    
    @Binding var keys: [String]
    
    @Binding var isKeyboardOpen: Bool
    
    @State var info: Bool = false
    
   
    @ObservedObject var motionManager = MotionManager()
    var body: some View {
        ZStack(alignment: .top) {
        VStack {
           // Spacer(minLength: screenSize.height/1.7)
            Color(.clear)
                .onAppear() {
                    let defaults = UserDefaults.standard
                    let timeNew = defaults.double(forKey: "timeNew")
                    let timeReg = defaults.double(forKey: "timeReg")
                    let x = defaults.array(forKey: "x")
                    let y = defaults.array(forKey: "y")
                    let z = defaults.array(forKey: "z")
                    let keys = defaults.stringArray(forKey: "keys")
                    print("timeNew: \(timeNew)")
                    print("timeReg: \(timeReg)")
                    print("x: \(x)")
                    print("y: \(y)")
                    print("z: \(z)")
                    print("keys: \(keys)")
                    
                       
                    
                          
                            
                    
                }
         
            ZStack(alignment: .center) {
                Image("keyboardBackground")
                    .resizable()
                    .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
              
                VStack {
                    
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(data, id: \.self) { item in
                        ZStack {
                            
                            if item != "backspace" {
                                if item != "space" {
                                    Color(.white)
                                        .frame(width: screenSize.width/11, height: screenSize.width/8, alignment: .center)
                                    Text(item)
                                        .font(.headline)
                                }
                            }
                            if item == "backspace" {
                               // Color(.white)
                                    //.frame(width: screenSize.width/9, height: screenSize.width/8, alignment: .center)
                                    //.padding(.leading)
                            }
                           
                        } .onTapGesture {
                             key = item
                            
                        }
                        .padding()
                    }
                    
                    
                   
                } 
                .padding()
                    Color(.white)
                        .frame(width: screenSize.width/1.1, height: 40)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            text += " "
                            if text == "Type here" {
                                text = ""
                            }
                        })
                        .padding(.bottom, 42)
                }
            }
            .onTapGesture {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    time += 0.1
                    let defaults = UserDefaults.standard
                    defaults.set(time, forKey: "timeNew")
                    x.append(motionManager.x)
                    y.append(motionManager.y)
                    z.append(motionManager.z)
                    if text.contains("k") {
                        timer.invalidate()
                        let defaults = UserDefaults.standard
                        defaults.set(x, forKey: "x")
                        defaults.set(y, forKey: "y")
                        defaults.set(z, forKey: "z")
                        defaults.set(keys, forKey: "keys")
                    }
                }
            }
            .simultaneousGesture( DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { dragGesture in
               
               let xPos = dragGesture.location.x
              let yPos = dragGesture.location.y
           
           print(yPos)
                if yPos < screenSize.height * 8/9 {
           if xPos > screenSize.width * 1/3 {
               if xPos < screenSize.width * 2/3 {
                   print(1)
                   zoom2.toggle()
                zoomed.toggle()
               }
           }
               if xPos > screenSize.width * 2/3 {
                   if xPos < screenSize.width {
                       print(2)
                       zoom3.toggle()
                    zoomed.toggle()
                   }
               }
               if xPos > 0 {
                   if xPos < screenSize.width * 1/3 {
                       print(0)
                       zoom1.toggle()
                    zoomed.toggle()
                   }
               }
                }
       })
              
            }
            if zoom1 {
                Image("keyboardBackground")
                    .resizable()
                    .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        
                        zoom1.toggle()
                        zoomed.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/2.5)
                    //Text(text)
                        
                       // .font(.headline)
                       // .padding()
                        //.frame(width: screenSize.width/1.5, alignment: .leading)
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal1, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                text += item
                            
                                keys.append(item)
                                print(keys)
                                print(x)
                                keysTime.append(time)
                                zoom1.toggle()
                                zoomed.toggle()
                                
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom)
            }
            if zoom2 {
                Image("keyboardBackground")
                    .resizable()
                    .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        zoom2.toggle()
                        zoomed.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/2.5)
                   
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal2, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                text += item
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                keys.append(item)
                                print(keys)
                                print(x)
                                keysTime.append(time)
                                zoom2.toggle()
                                zoomed.toggle()
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                } .padding(.bottom, 22)
            }
            if zoom3 {
               
                Image("keyboardBackground")
                    .resizable()
                    .frame(height: 300, alignment: .bottom)
                    .scaledToFit()
                BlurView(style: .systemChromeMaterialLight)
                    .onTapGesture() {
                        zoom3.toggle()
                        zoomed.toggle()
                    }
                VStack {
                    Spacer(minLength: screenSize.height/2.5)
                   
                    LazyVGrid(columns: columns1, spacing: 5) {
                        ForEach(horizontal3, id: \.self) { item in
                            ZStack {
                                if item == key {
                                    Color(.systemBlue)
                                    .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.white)
                                } else {
                                    Color(.white)
                                        .frame(width: screenSize.width/3.5, height: screenSize.width/5.5, alignment: .center)
                                    Text(item)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                
                                
                            } .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                if text == "Type Here" {
                                    text = ""
                                }
                                if item == "backspace" {
                                    if text.count > 0 {
                                text.removeLast()
                                    }
                                } else {
                                    text += item
                                }
                                x.append(motionManager.x)
                                y.append(motionManager.y)
                                z.append(motionManager.z)
                                keys.append(item)
                                print(keys)
                                print(x)
                                keysTime.append(time)
                                zoom3.toggle()
                                zoomed.toggle()
                            })
                            .padding()
                        }
                        
                    
                   
                }
                .padding()
                   
                }
            }
        
           
            }
        
    }
        }
      

    





struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(visualEffectView)
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
    }
}

struct VibrancyView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    let image: UIImage

    func makeUIView(context: UIViewRepresentableContext<VibrancyView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear

        let layoutView = UIView()
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        layoutView.backgroundColor = .clear
        view.addSubview(layoutView)

        let blurEffect = UIBlurEffect(style: style)

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vibrancyEffectView.frame = view.bounds

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        vibrancyEffectView.contentView.addSubview(imageView)

        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        view.addSubview(blurredEffectView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor),
            layoutView.topAnchor.constraint(equalTo: view.topAnchor),
            layoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: layoutView.bottomAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VibrancyView>) {
    }
}
struct ContentView3: View {
    
    @State var x = ""
    
    @State var y = ""
    
    @State var z = ""
    
    @State var keys = ""
    
    @Binding var isKeyboardOpen: Bool
    
    @State var info: Bool = false
    @ObservedObject var motionManager = MotionManager()
    var body: some View {
        ZStack {
        VStack {
            Text(x)
            Text(y)
            Text(z)
            Text(keys)
        }
    }
    }
}
