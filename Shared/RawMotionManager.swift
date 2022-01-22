//
//  RawMotionManager.swift
//  Environment
//
//  Created by Leptos on 1/21/22.
//

import Foundation
import CoreMotion

protocol RawMotionManager: ObservableObject {
    associatedtype DataType: CMLogItem
    
    var isAvailable: Bool { get }
    var isActive: Bool { get }
    
    var updateInterval: TimeInterval { get set }
    
    var data: DataType? { get }
    
    func startUpdates()
    func stopUpdates()
    
    // -
    
    func formattedData(_ data: DataType) -> String
}

extension MotionManager.Accelerometer: RawMotionManager {
    func formattedData(_ data: CMAccelerometerData) -> String {
        let acceleration = data.acceleration
        return String(format: "(%.1f, %.1f, %.1f)", acceleration.x, acceleration.y, acceleration.z)
    }
}

extension MotionManager.Gyro: RawMotionManager {
    func formattedData(_ data: CMGyroData) -> String {
        let rotationRate = data.rotationRate
        return String(format: "(%.1f, %.1f, %.1f)", rotationRate.x, rotationRate.y, rotationRate.z)
    }
}

extension MotionManager.Magnetometer: RawMotionManager {
    func formattedData(_ data: CMMagnetometerData) -> String {
        let magneticField = data.magneticField
        return String(format: "(%.1f, %.1f, %.1f)", magneticField.x, magneticField.y, magneticField.z)
    }
}
