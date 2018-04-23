//
//  ListViewModel.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import Foundation

public protocol WorkoutListViewModelProtocol {
    
    var items: UInt { get }
    var data: (_ item: UInt) -> WorkoutViewModel { get }
    var deleteAction: (_ item: UInt) -> Void { get }
    
}

public struct WorkoutListViewModel: WorkoutListViewModelProtocol {
    
    public let items: UInt
    public let data: (UInt) -> WorkoutViewModel

    //public let emptyListViewModel: TitleDescriptionViewModelProtocol?
    public let deleteAction: (UInt) -> Void
    
}

extension WorkoutListViewModel {
    
    public init() {
        items = 0
        
        data = { _ in WorkoutViewModel() }

        deleteAction = { _ in print("Delete action") }
        
    }
    
}

extension WorkoutListViewModel {
    
    public init(with workouts: [Fitness],
                deleteFitness: @escaping (Fitness) -> Void) {
        items = UInt(workouts.count)
        data = { WorkoutViewModel(with: workouts[Int($0)], large: $0 == 0) }
        
        deleteAction =  { deleteFitness(workouts[Int($0)]) }
    }
    
}
