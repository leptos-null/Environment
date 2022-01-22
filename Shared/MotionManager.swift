//
//  MotionManager.swift
//  EnvironmentKit
//
//  Created by Leptos on 1/21/22.
//

import Foundation
import CoreMotion

final class MotionManager {
    private let manager = CMMotionManager()
    
    lazy var accelerometer = Accelerometer(motionManager: manager)
    lazy var gyro = Gyro(motionManager: manager)
    lazy var magnetometer = Magnetometer(motionManager: manager)
}

extension MotionManager {
    final class Accelerometer: ObservableObject {
        private let motionManager: CMMotionManager
        
        init(motionManager: CMMotionManager) {
            self.motionManager = motionManager
        }
        
        var isAvailable: Bool { motionManager.isAccelerometerAvailable }
        var isActive: Bool { motionManager.isAccelerometerActive }
        
        var updateInterval: TimeInterval {
            get { motionManager.accelerometerUpdateInterval }
            set { motionManager.accelerometerUpdateInterval = newValue }
        }
        
        @Published var data: CMAccelerometerData?
        
        func startUpdates() {
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                guard let data = data else {
                    print("error", String(describing: error))
                    return
                }
                self?.data = data
            }
        }
        func stopUpdates() {
            motionManager.stopAccelerometerUpdates()
        }
    }
}

extension MotionManager {
    final class Gyro: ObservableObject {
        private let motionManager: CMMotionManager
        
        init(motionManager: CMMotionManager) {
            self.motionManager = motionManager
        }
        
        var isAvailable: Bool { motionManager.isGyroAvailable }
        var isActive: Bool { motionManager.isGyroActive }
        
        var updateInterval: TimeInterval {
            get { motionManager.gyroUpdateInterval }
            set { motionManager.gyroUpdateInterval = newValue }
        }
        
        @Published var data: CMGyroData?
        
        func startUpdates() {
            motionManager.startGyroUpdates(to: .main) { [weak self] data, error in
                guard let data = data else {
                    print("error", String(describing: error))
                    return
                }
                self?.data = data
            }
        }
        func stopUpdates() {
            motionManager.stopGyroUpdates()
        }
    }
}

extension MotionManager {
    final class Magnetometer: ObservableObject {
        private let motionManager: CMMotionManager
        
        init(motionManager: CMMotionManager) {
            self.motionManager = motionManager
        }
        
        var isAvailable: Bool { motionManager.isMagnetometerAvailable }
        var isActive: Bool { motionManager.isMagnetometerActive }
        
        var updateInterval: TimeInterval {
            get { motionManager.magnetometerUpdateInterval }
            set { motionManager.magnetometerUpdateInterval = newValue }
        }
        
        @Published var data: CMMagnetometerData?
        
        func startUpdates() {
            motionManager.startMagnetometerUpdates(to: .main) { [weak self] data, error in
                guard let data = data else {
                    print("error", String(describing: error))
                    return
                }
                self?.data = data
            }
        }
        func stopUpdates() {
            motionManager.stopMagnetometerUpdates()
        }
    }
}
