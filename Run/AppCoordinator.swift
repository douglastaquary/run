//
//  AppCoordinator.swift
//  Run
//
//  Created by Douglas Taquary on 21/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class AppCoordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard.main()
    let fitnessService = FitnessService()
    
    public init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = storyboard.viewController(withID: .signInViewController) as! SignInViewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func startInitialLocationInMap() {
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: ViewControllerStoryboardIdentifier.runMapViewController.rawValue) as! RunMapViewController
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func startActivityController() {
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: ViewControllerStoryboardIdentifier.activityViewController.rawValue) as! ActivityViewController
        
        self.navigationController.present(viewController, animated: true, completion: nil)
    }
    
    public func startWokoutList() {
        let viewController = WorkoutListViewController(with: fitnessService)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func startResume(last fitness: Fitness?) {
        let resumeController = ResumeViewController(with: fitnessService,
                                                    currentFitness: fitness ?? Fitness())
        resumeController.delegate = self
        self.navigationController.present(resumeController, animated: true, completion: nil)
    }
    
    public func startPermissionRequest() {
        let permissionController = PermissionRequestViewController()
        permissionController.delegate = self
        self.navigationController.present(permissionController, animated: true, completion: nil)
    }
}

extension AppCoordinator: WorkoutListViewControllerDelegate {
    public func failedToDeleteFitness() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.navigationController.present(alert, animated: true, completion: nil)
    }
}

extension AppCoordinator: ResumeViewControllerDelegate {
    public func didEnd(on viewController: ResumeViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}

extension AppCoordinator: PermissionRequestViewControllerDelegate {
    public func didFinish(on controller: PermissionRequestViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


extension AppCoordinator: ActivityViewControllerDelegate {
    public func didStop(with fitness: Fitness) {
        startResume(last: fitness)
    }

}






