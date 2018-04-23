//
//  ActivityViewModel.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol ActivityViewModelProtocol {
    var currentFitness: Fitness { get }
    var didTapStopAction: (Fitness) -> Void { get }
    var didTapStartAction: () -> Void { get }
    var isRunning: Bool { get }
}

public struct ActivityViewModel: ActivityViewModelProtocol {
    public var currentFitness: Fitness

    public let didTapStartAction: () -> Void
    public let didTapStopAction: (Fitness) -> Void
    
    public let isRunning: Bool

}

extension ActivityViewModel {
    
    public init() {
        let fitness = Fitness()
        self.init(currentFitness: fitness,
                  didTapStartAction: { print("Iniciar") },
                  didTapStopAction: { _ in print("Stop") })
    }
    
    public init(currentFitness: Fitness,
                didTapStartAction: @escaping () -> Void,
                didTapStopAction: @escaping (Fitness) -> Void) {
        
        //let style: StyleProvider = Style()

        isRunning = false
        
        self.currentFitness = Fitness(date: Date(), distance: currentFitness.distance, kilometersPerHour: currentFitness.kilometersPerHour, time: currentFitness.time)
        self.didTapStartAction = didTapStartAction
        self.didTapStopAction = didTapStopAction
    }
    
}

