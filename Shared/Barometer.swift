//
//  Barometer.swift
//  Environment
//
//  Created by Leptos on 1/21/22.
//

import Foundation
import CoreMotion

final class Barometer: ObservableObject {
    private let altimeter = CMAltimeter()
    
    class var isAvailable: Bool { CMAltimeter.isRelativeAltitudeAvailable() }
    
    @Published var data: CMAltitudeData?
    
    func startUpdates() {
        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let data = data else {
                print("error", String(describing: error))
                return
            }
            self?.data = data
        }
    }
    func stopUpdates() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}
