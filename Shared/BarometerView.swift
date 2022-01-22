//
//  BarometerView.swift
//  Environment
//
//  Created by Leptos on 1/21/22.
//

import Foundation
import SwiftUI
import CoreMotion

struct BarometerView: View {
    @StateObject var barometer: Barometer
    @State var unit: UnitPressure = .kilopascals
    
    private let units: [UnitPressure] = [
        .newtonsPerMetersSquared,
        .kilopascals,
        .inchesOfMercury,
        .bars,
        .millibars,
        .millimetersOfMercury,
        .poundsForcePerSquareInch
    ]
    
    static let measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
        formatter.locale = .autoupdatingCurrent
        formatter.numberFormatter.minimumFractionDigits = 4
        formatter.numberFormatter.maximumFractionDigits = 4
        return formatter
    }()
    
    private func formatted(data: CMAltitudeData) -> String {
        let measurement = Measurement(value: data.pressure.doubleValue, unit: UnitPressure.kilopascals)
        return Self.measurementFormatter.string(from: measurement.converted(to: unit))
    }
    
    var body: some View {
        if Barometer.isAvailable {
            VStack {
                if let data = barometer.data {
                    Text(formatted(data: data))
                } else {
                    ProgressView()
                }
                
                Picker(selection: $unit) {
                    ForEach(units, id: \.self) { unit in
                        Text(Self.measurementFormatter.string(from: unit))
                    }
                } label: {
                    Text("Unit")
                        .font(.headline)
                }
            }
            .onAppear(perform: barometer.startUpdates)
            .onDisappear(perform: barometer.stopUpdates)
        }
    }
}
