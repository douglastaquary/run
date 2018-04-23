//
//  ActivityView.swift
//  Run
//
//  Created by Douglas Taquary on 09/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class ActivityView: UIView {
    
    var timeItem: ActivityViewItem = ActivityViewItem()
    var milhasItem: ActivityViewItem = ActivityViewItem()
    var pulseItem: ActivityViewItem = ActivityViewItem()
    var actionFooter = ActivityViewFooter()
    
    //MARK: - Timer
    var zeroTime = TimeInterval()
    var timer: Timer = Timer()
    var userActivityState = UserActivityState.stop
    var distanceTraveled = 0.0
    
    public var viewModel: ActivityViewModelProtocol = ActivityViewModel() {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateView() {
        
        pulseItem.descriptionLabel.text = "RÍTIMO MÉDIO"
        pulseItem.detailLabel.text = "/MI"
        
        milhasItem.descriptionLabel.text = "DISTÂNCIA"
        milhasItem.detailLabel.text = "KM"
        
        timeItem.descriptionLabel.text = "TEMPO"
        timeItem.detailLabel.text = ""
//        distanceLabel.text = "\(Double(viewModel.currentFitness.distance.value))"
//        timeLabel.text = viewModel.currentFitness.time
//        kmPerHourLabel.text = "\(Double(viewModel.currentFitness.kilometersPerHour.value))"
//        caloriesLabel.text = "325 cal"
        
    }
    
    func setupView() {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        if #available(iOS 11.0, *) {
            contentView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            contentView.leftAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
            contentView.rightAnchor
                .constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
            contentView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }

        
        contentView.backgroundColor = UIColor.black
        contentView.layer.opacity = 0.75
        
        timeItem.translatesAutoresizingMaskIntoConstraints = false
        milhasItem.translatesAutoresizingMaskIntoConstraints = false
        pulseItem.translatesAutoresizingMaskIntoConstraints = false
        actionFooter.translatesAutoresizingMaskIntoConstraints = false
        
        actionFooter.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        actionFooter.startButton.addTarget(self, action: #selector(startTap), for: .touchUpInside)
        actionFooter.stopButton.addTarget(self, action: #selector(stopTap), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(timeItem)
        stackView.addArrangedSubview(pulseItem)
        stackView.addArrangedSubview(milhasItem)
        stackView.addArrangedSubview(actionFooter)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    @objc func startTap() {
        viewModel.didTapStartAction()
    }
    
    @objc func stopTap() {
        let fitness = Fitness(date: Date(),
                              distance: viewModel.currentFitness.distance,
                              kilometersPerHour: viewModel.currentFitness.kilometersPerHour,
                              time: viewModel.currentFitness.time)
        viewModel.didTapStopAction(fitness)
    }


}


