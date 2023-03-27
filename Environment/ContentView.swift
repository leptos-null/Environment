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
                    Label("Barometer", systemImage: "barometer")
                }
            RawMotionManagerView(rawMotionManager: motionManager.accelerometer)
                .tabItem {
                    Label("Accelerometer", systemImage: "level")
                }
            RawMotionManagerView(rawMotionManager: motionManager.gyro)
                .tabItem {
                    Label("Gyro", systemImage: "gyroscope")
                }
            RawMotionManagerView(rawMotionManager: motionManager.magnetometer)
                .tabItem {
                    Label("Magnetometer", systemImage: "cube")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
