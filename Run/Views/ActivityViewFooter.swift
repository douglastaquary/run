//
//  ActivityViewFooter.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class ActivityViewFooter: UIView {
    
    var stopButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
       return btn
    }()
    
    var startButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let contentView = self
        let grid: CGFloat = 8
        
        contentView.backgroundColor = UIColor.black
        contentView.layer.opacity = 0.75
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.layer.cornerRadius = 12
        stopButton.backgroundColor = .red
        stopButton.layer.borderColor = UIColor.clear.cgColor
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.cornerRadius = 12
        startButton.backgroundColor = .green
        startButton.layer.borderColor = UIColor.clear.cgColor
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = grid * grid
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(startButton)
        
        contentView.addSubview(stackView)
        
        stopButton.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(didTapStart(with:)), for: .touchUpInside)
    }
    
    
    func stateButtonSetup(with state: Bool) {
        startButton.layer.cornerRadius = 12
        startButton.backgroundColor = state ? .green : .orange
        startButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    @objc func didTapStop() {
        print("Stop button..")
    }
    
    @objc func didTapStart(with state: Bool) {
        stateButtonSetup(with: state)
    }
    		
    
    
}
