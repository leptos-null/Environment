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
            RawMotionManagerView(rawMotionManager: motionManager.accelerometer)
                .tabItem {
                    Image(systemName: "level")
                    Text("Accelerometer")
                }
            RawMotionManagerView(rawMotionManager: motionManager.gyro)
                .tabItem {
                    Image(systemName: "gyroscope")
                    Text("Gyro")
                }
            RawMotionManagerView(rawMotionManager: motionManager.magnetometer)
                .tabItem {
                    Image(systemName: "cube")
                    Text("Magnetometer")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
