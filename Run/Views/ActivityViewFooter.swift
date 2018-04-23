//
//  ActivityViewFooter.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class ActivityViewFooter: BaseViewTemplate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var userActivityState = UserActivityState.stop
    
    public var viewModel: ActivityViewModelProtocol = ActivityViewModel() {
        didSet {
            updateView()
        }
    }
    
    public override func awakeFromNib() {
        updateView()
    }
    
    func updateView() {
        managerStateButton(with: userActivityState)
    }
    
    func managerStateButton(with state: UserActivityState) {
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        startButton.backgroundColor = state == .stop ? Style().tintColor : .orange
        startButton.layer.borderColor = UIColor.clear.cgColor
        startButton.setTitle(state == .stop ? "INICIAR" : "PAUSAR", for: .normal)
    }
    
    @IBAction func didTapStop(_ sender: Any) {
        viewModel.didTapStopAction(Fitness())
    }
    
    @IBAction func didTapStart(_ sender: Any) {
        
        viewModel.didTapStartAction()

        if userActivityState == .stop {
            managerStateButton(with: UserActivityState.running)
            userActivityState = .running
        } else {
            managerStateButton(with: UserActivityState.stop)
            userActivityState = .stop
        }
        
    }
  
}
