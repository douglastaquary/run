//
//  ResumeViewController.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol ResumeViewControllerDelegate {
    func didEnd(on viewController: ResumeViewController)
}

public class ResumeViewController: UIViewController {
    
    let fitnessService: FitnessRepository
    let currentFitness: Fitness
    
    public required init(with fitnessService: FitnessRepository, currentFitness: Fitness) {
        self.fitnessService = fitnessService
        self.currentFitness = currentFitness
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var delegate: ResumeViewControllerDelegate?
    
    var theView: ResumeView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! ResumeView
    }
    
    override public func loadView() {
        let view = ResumeView()
        self.view = view
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let viewModel =
            ResumeViewModel(currentFitness: currentFitness,
                            didTapSaveAction: { [weak self] fitness in self?.saveFitness(fitness) },
                            didTapStopAction: { [weak self] in self?.didEnd() })
        
        theView.viewModel = viewModel
    }
    
    override public func viewDidLoad() {

    }
    
    func saveFitness(_ fitness: Fitness) {
        
        fitnessService.save(fitness) { (error) in
            print("Error = \(error.debugDescription)")
        }
        
        didEnd()
    }
    
    func didEnd() {
        delegate?.didEnd(on: self)
    }

}
