//
//  ActivityViewController.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol ActivityViewControllerDelegate {
    func didStop(with fitness: Fitness)
}

public class ActivityViewController: UIViewController {
    
    let currentFitness: Fitness = Fitness()
    
    //MARK: - Timer
    var zeroTime = TimeInterval()
    var timer: Timer = Timer()
    var userActivityState = UserActivityState.stop
    var distanceTraveled = 0.0
    
    public var delegate: ActivityViewControllerDelegate?
    
    var theView: ActivityView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! ActivityView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel =
            ActivityViewModel(currentFitness: currentFitness,
                              didTapStartAction: { [weak self] in self?.configureTimer() },
                              didTapStopAction: { [weak self] fitness in self?.stopTap(fitness) })
        
        theView.viewModel = viewModel
        observeTimerUpdate()
    }
    
    override public func loadView() {
        // To avoid warnings of autolayout while the view
        // is not resized by the system
        let frame = UIScreen.main.bounds
        let view = ActivityView(frame: frame)
        self.view = view
    }
    
    var timerObserver: NSObjectProtocol? = nil
    func observeTimerUpdate() {
        let center = NotificationCenter.default
        if let timerObserver = timerObserver {
            center.removeObserver(timerObserver)
            self.timerObserver = nil
        }
        
        center.addObserver(forName: .ActivityTimerDidUpdate,
                           object: nil,
                           queue: .main) { [weak self] _ in
                            self?.configureTimer()
        }
    }
    
    func stopTap(_ fitness: Fitness) {
        delegate?.didStop(with: fitness)
    }
    
    func configureTimer() {
        if userActivityState == .stop {
            startTimer()
            userActivityState = UserActivityState.running
        } else {
            stopTimer()
            userActivityState = UserActivityState.stop
        }
    }


}

extension ActivityViewController {
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
        zeroTime = Date.timeIntervalSinceReferenceDate
    }
    
    func stopTimer() {
        timer.invalidate()
    }

    @objc func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        var timePassed: TimeInterval = currentTime - zeroTime
        let minutes = UInt8(timePassed / 60.0)
        timePassed -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(timePassed)
        timePassed -= TimeInterval(seconds)
        let millisecsX10 = UInt8(timePassed * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMSX10 = String(format: "%02d", millisecsX10)
        
        theView.timeItem.largeValueLabel.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
        
        if theView.timeItem.largeValueLabel.text == "60:00:00" {
            timer.invalidate()
        }
    }
}

