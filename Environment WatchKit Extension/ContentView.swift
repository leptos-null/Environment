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
                            .navigationTitle("Barometer")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Barometer", systemImage: "barometer")
                    }
                }
                if motionManager.accelerometer.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.accelerometer)
                            .navigationTitle("Accelerometer")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Accelerometer", systemImage: "level")
                    }
                }
                if motionManager.gyro.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.gyro)
                            .navigationTitle("Gyro")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Gyro", systemImage: "gyroscope")
                    }
                }
                if motionManager.magnetometer.isAvailable {
                    NavigationLink {
                        RawMotionManagerView(rawMotionManager: motionManager.magnetometer)
                            .navigationTitle("Magnetometer")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Magnetometer", systemImage: "cube")
                    }
                }
            }
            .navigationTitle("Environment")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
