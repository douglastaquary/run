//
//  ResumeViewModel.swift
//  Run
//
//  Created by Douglas Taquary on 21/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol ResumeViewModelProtocol {
    var cancelTitle: NSAttributedString { get }
    var saveTitle: NSAttributedString { get }
    var currentFitness: Fitness { get }
    var didTapStopAction: () -> Void { get }
    var didTapSaveAction: (Fitness) -> Void { get }
}

public struct ResumeViewModel: ResumeViewModelProtocol {
    public var currentFitness: Fitness
    
    public let cancelTitle: NSAttributedString
    public let saveTitle: NSAttributedString
    
    public let didTapSaveAction: (Fitness) -> Void
    public let didTapStopAction: () -> Void
    
    public let title: NSAttributedString
    public let flexibleHeight: Bool
    
    public let steps: [ImageTextViewModelProtocol]
    
}

extension ResumeViewModel {
    
    public init() {
        let fitness = Fitness()
        self.init(currentFitness: fitness,
                  didTapSaveAction: { _ in print("Save") },
                  didTapStopAction: { print("Stop") })
    }
    
    public init(currentFitness: Fitness,
                didTapSaveAction: @escaping (Fitness) -> Void,
                didTapStopAction: @escaping () -> Void) {
        
        let style: StyleProvider = Style()
        
        saveTitle = NSAttributedString(string: "Salvar",
                                   font: style.title2,
                                   color: style.textColor)
        
        cancelTitle = NSAttributedString(string: "Cancelar",
                                       font: style.title2,
                                       color: style.textColor)
        
        title = NSAttributedString(string: "Run precisa de acesso ao App Saúde para salvar seus progressos",
                                   font: style.title2,
                                   color: style.textColor)
        flexibleHeight = false
        
        steps = PermissionRequestViewModel.buildSteps()

        self.currentFitness = Fitness(date: Date(), distance: currentFitness.distance, kilometersPerHour: currentFitness.kilometersPerHour, time: currentFitness.time)
        self.didTapSaveAction = didTapSaveAction
        self.didTapStopAction = didTapStopAction
    }

}

