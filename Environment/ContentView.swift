//
//  ContentView.swift
//  Environment
//
//  Created by Leptos on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    let motionManager = MotionManager()
    let barometer = Barometer()
    
    var body: some View {
        TabView {
            BarometerView(barometer: barometer)
                .tabItem {
                    Image(systemName: "barometer")
                    Text("Barometer")
                    
                }
            AccelerometerView(accelerometerManager: motionManager.accelerometer)
                .tabItem {
                    Image(systemName: "level")
                    Text("Accelerometer")
                }
            GyroView(gyroManager: motionManager.gyro)
                .tabItem {
                    Image(systemName: "gyroscope")
                    Text("Gyro")
                }
            
            MagnetometerView(magnetometerManager: motionManager.magnetometer)
                .tabItem {
                    Image(systemName: "cube")
                    Text("Magnetometer")
                }
        }
    }
}

struct BarometerView: View {
    @StateObject var barometer: Barometer
    
    private var text: String {
        guard let pressure = barometer.data?.pressure else { return "nil" }
        return Measurement(value: pressure.doubleValue, unit: UnitPressure.kilopascals)
            .converted(to: .inchesOfMercury)
            .formatted(.measurement(
                width: .narrow, usage: .general, numberFormatStyle: .number.rounded(increment: 1e-6)
            ))
    }
    
    var body: some View {
        if Barometer.isAvailable {
            Text(text)
                .onAppear {
                    barometer.startUpdates()
                }
                .onDisappear {
                    barometer.stopUpdates()
                }
        }
    }
}

struct AccelerometerView: View {
    @StateObject var accelerometerManager: MotionManager.Accelerometer
    
    private var updateIntervalBinding: Binding<TimeInterval> {
        Binding {
            accelerometerManager.updateInterval
        } set: {
            accelerometerManager.updateInterval = $0
        }
    }
    
    private var text: String {
        guard let accelerometerData = accelerometerManager.data else { return "nil" }
        let acceleration = accelerometerData.acceleration
        return String(format: "(%.1f, %.1f, %.1f)", acceleration.x, acceleration.y, acceleration.z)
    }
    
    var body: some View {
        if accelerometerManager.isAvailable {
            VStack {
                Text(text)
                    .onAppear {
                        accelerometerManager.startUpdates()
                    }
                    .onDisappear {
                        accelerometerManager.stopUpdates()
                    }
                
                Stepper(value: updateIntervalBinding, step: 0.01) {
                    Text("Update Interval: \(updateIntervalBinding.wrappedValue.formatted(.number.rounded(increment: 0.01)))")
                }
            }
        }
    }
}

struct GyroView: View {
    @StateObject var gyroManager: MotionManager.Gyro
    
    private var updateIntervalBinding: Binding<TimeInterval> {
        Binding {
            gyroManager.updateInterval
        } set: {
            gyroManager.updateInterval = $0
        }
    }
    
    private var text: String {
        guard let gyroData = gyroManager.data else { return "nil" }
        let rotationRate = gyroData.rotationRate
        return String(format: "(%.1f, %.1f, %.1f)", rotationRate.x, rotationRate.y, rotationRate.z)
    }
    
    var body: some View {
        if gyroManager.isAvailable {
            VStack {
                Text(text)
                    .onAppear {
                        gyroManager.startUpdates()
                    }
                    .onDisappear {
                        gyroManager.stopUpdates()
                    }
                
                Stepper(value: updateIntervalBinding, step: 0.01) {
                    Text("Update Interval: \(updateIntervalBinding.wrappedValue.formatted(.number.rounded(increment: 0.01)))")
                }
            }
        }
    }
}

struct MagnetometerView: View {
    @StateObject var magnetometerManager: MotionManager.Magnetometer
    
    private var updateIntervalBinding: Binding<TimeInterval> {
        Binding {
            magnetometerManager.updateInterval
        } set: {
            magnetometerManager.updateInterval = $0
        }
    }
    
    private var text: String {
        guard let magnetometerData = magnetometerManager.data else { return "nil" }
        let magneticField = magnetometerData.magneticField
        return String(format: "(%.1f, %.1f, %.1f)", magneticField.x, magneticField.y, magneticField.z)
    }
    
    var body: some View {
        if magnetometerManager.isAvailable {
            VStack {
                Text(text)
                    .onAppear {
                        magnetometerManager.startUpdates()
                    }
                    .onDisappear {
                        magnetometerManager.stopUpdates()
                    }
                
                Stepper(value: updateIntervalBinding, step: 0.01) {
                    Text("Update Interval: \(updateIntervalBinding.wrappedValue.formatted(.number.rounded(increment: 0.01)))")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
