//
//  RawMotionManagerView.swift
//  Environment
//
//  Created by Leptos on 1/21/22.
//

import Foundation
import SwiftUI
import CoreMotion

struct RawMotionManagerView<Manager: RawMotionManager>: View {
    @StateObject var rawMotionManager: Manager
    
    private var updateIntervalText: String {
        rawMotionManager.updateInterval.formatted(.number.rounded(increment: updateIntervalIncrement))
    }
    
    private let updateIntervalIncrement: TimeInterval.Stride = 0.01
    
    var body: some View {
        if rawMotionManager.isAvailable {
            VStack {
                if let data = rawMotionManager.data {
                    Text(rawMotionManager.formattedData(data))
                } else {
                    ProgressView()
                }
#if os(watchOS)
                Slider(value: $rawMotionManager.updateInterval, in: 0...1, step: updateIntervalIncrement) {
                    Text("Update Interval: \(updateIntervalText)")
                }
#else
                Stepper(value: $rawMotionManager.updateInterval, step: updateIntervalIncrement) {
                    Text("Update Interval: \(updateIntervalText)")
                }
                .padding()
#endif
            }
            .onAppear(perform: rawMotionManager.startUpdates)
            .onDisappear(perform: rawMotionManager.stopUpdates)
        }
    }
}

final class RawMotionManagerShim: RawMotionManager {
    final class LogItemShim: CMLogItem {
        let scalar: Int
        
        init(scalar: Int) {
            self.scalar = scalar
            super.init()
        }
        
        private let scalarCodingKey = "LogItemShimScalarKey"
        
        required init?(coder: NSCoder) {
            self.scalar = coder.decodeInteger(forKey: scalarCodingKey)
            super.init(coder: coder)
        }
        override func encode(with coder: NSCoder) {
            super.encode(with: coder)
            coder.encode(self.scalar, forKey: scalarCodingKey)
        }
    }
    
    private var timer: Timer? = nil
    
    let isAvailable: Bool
    var isActive: Bool { timer?.isValid == true }
    
    var updateInterval: TimeInterval {
        didSet {
            guard isActive else { return }
            stopUpdates()
            startUpdates()
        }
    }
    
    @Published private(set) var data: LogItemShim?
    
    func startUpdates() {
        timer = .scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] timer in
            self?.data = LogItemShim(scalar: .random(in: 0...9))
        }
    }
    func stopUpdates() {
        timer?.invalidate()
        timer = nil
    }
    
    func formattedData(_ data: LogItemShim) -> String {
        data.scalar.formatted()
    }
    
    init(isAvailable: Bool = true, updateInterval: TimeInterval = 0.01) {
        self.isAvailable = isAvailable
        self.updateInterval = updateInterval
        self.data = data
    }
}

struct RawMotionManagerView_Previews: PreviewProvider {
    static var previews: some View {
        RawMotionManagerView(rawMotionManager: RawMotionManagerShim())
    }
}
