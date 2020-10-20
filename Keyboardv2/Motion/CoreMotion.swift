//
//  CoreMotion.swift
//  Keyboardv2
//
//  Created by Andreas Ink on 10/6/20.
//


import Combine
import CoreMotion

class MotionManager: ObservableObject {

    private var motionManager: CMMotionManager

    @Published
    var x: Double = 0.0
    @Published
    var y: Double = 0.0
    @Published
    var z: Double = 0.0


    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        self.motionManager.startAccelerometerUpdates(to: .main) { (magnetometerData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let magnetData = magnetometerData {
                self.x = magnetData.acceleration.x
                self.y = magnetData.acceleration.y
                self.z = magnetData.acceleration.z
            }

        }

    }
}
