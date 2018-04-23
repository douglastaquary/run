//
//  WorkoutViewModel.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public struct WorkoutViewModel {
    
    public let distance: NSAttributedString
    public let kmPerHour: NSAttributedString
    public let date: NSAttributedString
    //public let time: NSAttributedString
    
}

extension WorkoutViewModel {
    
    public init() {
        distance = NSAttributedString()
        kmPerHour = NSAttributedString()
        date = NSAttributedString()
        //time = NSAttributedString()
    }
    
    
    public init(with workout: Fitness, large: Bool) {
        
        let style: StyleProvider = Style()
        let me = type(of: self)
        
        let distanceString = me.string(from: workout.distance)
        let kmPerHourString = me.string(from: workout.kilometersPerHour)
        
        self.distance = NSAttributedString(string: distanceString,
                                       font: large ? style.title1 : style.title2,
                                       color: style.tintColor)
        
        self.kmPerHour = NSAttributedString(string: kmPerHourString,
                                           font: large ? style.title1 : style.title2,
                                           color: style.tintColor)

        
        let date = me.dateFormatterDay.string(from: workout.date)
        let time = me.dateFormatterTime.string(from: workout.date)
        let dateString = "\(date)\n\(time)"
        
        let dateFont: UIFont
        let dateColor: UIColor
        
        if large {
            dateFont = style.subhead
            dateColor = style.tintColor
        } else {
            dateFont = style.footnote
            dateColor = style.textLightColor
        }
        
        self.date = NSAttributedString(string: dateString,
                                       font: dateFont,
                                       color: dateColor)
    }
    
    static func string(from fitness: Measurement<Unit>) -> String {
        var fitnessString = distanceKmFormatter.string(from: fitness)
        
        if fitnessString.isEmpty {
            fitnessString = distanceKmFormatter.string(from: fitness)
        }
        
        return fitnessString
    }
    
    static let distanceKmFormatter: MeasurementFormatter = {
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.numberFormatter.minimumFractionDigits = 1
        distanceFormatter.numberFormatter.maximumFractionDigits = 1
        distanceFormatter.unitOptions = .providedUnit
        
        return distanceFormatter
    }()
    
    static let kmPerHourFormatter: MeasurementFormatter = {
        let kmHourFormatter = MeasurementFormatter()
        kmHourFormatter.numberFormatter.minimumFractionDigits = 1
        kmHourFormatter.numberFormatter.maximumFractionDigits = 1
        
        return kmHourFormatter
    }()
    
    static let dateFormatterFull: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter
    }()
    
    static let dateFormatterDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter
    }()
    
    static let dateFormatterTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
}
