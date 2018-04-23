//
//  ResumeView.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit
import MapKit

class ResumeView: BaseViewTemplate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kmPerHourLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var calcelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        saveButton.addTarget(self, action: #selector(saveTap), for: .touchUpInside)
        calcelButton.addTarget(self, action: #selector(cancelTap), for: .touchUpInside)
    }
    
    
    public var viewModel: ResumeViewModelProtocol = ResumeViewModel() {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        distanceLabel.text = "\(Double(viewModel.currentFitness.distance.value))"
        timeLabel.text = viewModel.currentFitness.time
        kmPerHourLabel.text = "\(Double(viewModel.currentFitness.kilometersPerHour.value))"
        caloriesLabel.text = "325 cal"

    }
    
    @objc func saveTap() {
        let fitness = Fitness(date: Date(),
                              distance: viewModel.currentFitness.distance,
                              kilometersPerHour: viewModel.currentFitness.kilometersPerHour,
                              time: viewModel.currentFitness.time)
        viewModel.didTapSaveAction(fitness)
    }
    
    @objc func cancelTap() {
        viewModel.didTapStopAction()
    }
}
