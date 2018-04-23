//
//  WorkoutListViewController.swift
//  Run
//
//  Created by Douglas Taquary on 21/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol WorkoutListViewControllerDelegate {
    func failedToDeleteFitness()
}

public class WorkoutListViewController: UIViewController {
    
    let fitnessRepository: FitnessRepository
    var workouts: [Fitness] = [Fitness]() {
        didSet {
            updateView()
        }
    }
    
    public var delegate: WorkoutListViewControllerDelegate?
    
    var theView: WorkoutListView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! WorkoutListView
    }
    
    public required init(with fitnessRepository: FitnessRepository) {
        self.fitnessRepository = fitnessRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        // To avoid warnings of autolayout while the view
        // is not resized by the system
        let frame = UIScreen.main.bounds
        let view = WorkoutListView(frame: frame)
        self.view = view
    }
    
    public override func viewDidLoad() {
        automaticallyAdjustsScrollViewInsets = false
        loadWorkouts()
        observeWorkoutsUpdate()
    }
    
    func updateView() {
        let viewModel = WorkoutListViewModel(with: workouts) { [weak self] in self?.delete($0) }
        
        theView.viewModel = viewModel
    }
    
    public override func viewDidLayoutSubviews() {
        theView.topOffset = topLayoutGuide.length
    }
    
    var fitnessObserver: NSObjectProtocol? = nil
    func observeWorkoutsUpdate() {
        let center = NotificationCenter.default
        if let fitnessObserver = fitnessObserver {
            center.removeObserver(fitnessObserver)
            self.fitnessObserver = nil
        }
        
        center.addObserver(forName: .FitnessServiceDidUpdate,
                           object: fitnessRepository,
                           queue: .main) { [weak self] _ in
                            self?.loadWorkouts()
        }
    }
    
    func loadWorkouts() {
        workouts.removeAll()
        
        self.fitnessRepository.fetch { [weak self] (samples) in
            
            if samples.isEmpty {
                print("No samples")
            }
            
            self?.workouts.append(contentsOf: samples)
        }
    }
    
    func delete(_ fitness: Fitness) {
        self.fitnessRepository.delete(fitness) { [weak self] (error) in
            if let error = error {
                self?.failToDelete(error)
            }
        }
    }
    
    func failToDelete(_ error: Error) {
        print(error.localizedDescription)
        delegate?.failedToDeleteFitness()
    }
}

