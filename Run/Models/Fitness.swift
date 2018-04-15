//
//  Fitness.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import Foundation
import HealthKit

public struct Fitness {
    
    public let distance: Measurement<Unit>
    public let kilometersPerHour: Measurement<Unit>
    public let time: String
    public let date: Date
    let status: Status
    
    enum Status {
        case permanent(UUID)
        case transient
    }
    
}

extension Fitness {
    
    init() {
        date = Date()
        distance = Measurement(value: 0.0, unit: UnitLength.kilometers)
        kilometersPerHour = Measurement(value: 0.0, unit: UnitSpeed.kilometersPerHour)
        time = "00:00"
        status = .transient
    }
    
    init(date: Date, distance: Measurement<Unit>, kilometersPerHour: Measurement<Unit>, time: String) {
        self.date = date
        self.distance = distance
        self.kilometersPerHour = kilometersPerHour
        self.time = time
        status = .transient
    }
    
    init(with sample: HKQuantitySample) {
        distance = Measurement(value: sample.quantity.doubleValue(for: .meterUnit(with: .deca)),
                            unit: UnitLength.kilometers)
        kilometersPerHour = Measurement(value: sample.quantity.doubleValue(for: .meterUnit(with: .deci)),
                                        unit: UnitSpeed.kilometersPerHour)
        date = sample.startDate
        time = ""
        status = .permanent(sample.uuid)
    }
    
}
