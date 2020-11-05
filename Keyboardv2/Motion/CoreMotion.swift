//
//  CoreMotion.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/6/20.
//


import Combine
import CoreMotion

class MotionManager: ObservableObject {

     var motionManager: CMMotionManager

    @Published
    var x: Double = 0.0
    @Published
    var y: Double = 0.0
    @Published
    var z: Double = 0.0

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0
    
    @Published
    var rotX: Double = 0.0
    @Published
    var rotY: Double = 0.0
    @Published
    var rotZ: Double = 0.0
@Published
    var stop: Bool = false
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        
        self.motionManager.startAccelerometerUpdates(to: .main) { [weak self] (magnetometerData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
            if let magnetData = magnetometerData {
                self?.x = magnetData.acceleration.x
                self?.y = magnetData.acceleration.y
                self?.z = magnetData.acceleration.z
            }
            }

        }
        self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (magnetometerData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
            if let magnetData = magnetometerData {
                self?.pitch = magnetData.attitude.pitch
                self?.roll = magnetData.attitude.roll
                self?.yaw = magnetData.attitude.yaw
            }
            }

        }
        self.motionManager.startGyroUpdates(to: .main) { [weak self] (magnetometerData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
            if let magnetData = magnetometerData {
                self?.rotX = magnetData.rotationRate.x
                self?.rotY = magnetData.rotationRate.y
                self?.rotZ = magnetData.rotationRate.z
            }
            }

        }
    }
}
