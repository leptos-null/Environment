//
//  ContentView.swift
//  Environment WatchKit Extension
//
//  Created by Leptos on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    let motionManager = MotionManager()
    let barometer = Barometer()
    
    var body: some View {
        NavigationView {
            List {
                if Barometer.isAvailable {
                    NavigationLink {
                        BarometerView(barometer: barometer)
                    } label: {
                        Label("Barometer", systemImage: "barometer")
                    }
                }
                if motionManager.accelerometer.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.accelerometer)
                    } label: {
                        Label("Accelerometer", systemImage: "level")
                    }
                }
                if motionManager.gyro.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.gyro)
                    } label: {
                        Label("Gyro", systemImage: "gyroscope")
                    }
                }
                if motionManager.magnetometer.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.magnetometer)
                    } label: {
                        Label("Magnetometer", systemImage: "cube")
                    }
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
