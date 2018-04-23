//
//  PermissionRequestView.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class PermissionRequestView: UIView {
    
    var textView: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 0
        lb.font = Style().body
        return lb
    }()
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = Style().grid * 3
        view.axis = .vertical
        return view
    }()
    let okButton: TintButton = TintButton()
    
    let style: StyleProvider = Style()
    
    public var viewModel: PermissionRequestViewModelProtocol = PermissionRequestViewModel() {
        didSet {
            update()
        }
    }
    
    public var topOffset: CGFloat {
        set(topOffset) {
            topConstraint?.constant = topOffset
        }
        
        get {
            return topConstraint?.constant ?? 0
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
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
            topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
            topConstraint?.isActive = true
            contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        backgroundColor = style.backgroundColor
        
        let padding = style.grid * 3
        let buttonPadding = style.grid * 2
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        textView.setContentHuggingPriority(.required, for: .vertical)
        
        textView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        stackView.topAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                        constant: padding).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                         constant: -padding).isActive = true
        
        let guide = UILayoutGuide()
        contentView.addLayoutGuide(guide)
        guide.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        guide.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        guide.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(okButton)
        
        okButton.topAnchor.constraint(equalTo: guide.bottomAnchor,
                                      constant: buttonPadding).isActive = true
        okButton.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                       constant: buttonPadding).isActive = true
        okButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                        constant: -buttonPadding).isActive = true
        okButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                         constant: -buttonPadding).isActive = true
        
        okButton.addTarget(self,
                           action: #selector(PermissionRequestView.okTap),
                           for: .touchUpInside)
    }
    
    func update() {
        textView.attributedText = viewModel.title
        
        var oldViews = stackView.arrangedSubviews as? [ImageTextView]
        oldViews?.forEach { $0.removeFromSuperview() }
        let newViews = viewModel.steps.map { viewModel -> UIView in
            let view = oldViews?.popLast() ?? ImageTextView()
            view.viewModel = viewModel
            return view
        }
        newViews.forEach { stackView.addArrangedSubview($0) }
        
        okButton.title = viewModel.okTitle
    }
    
    @objc func okTap() {
        viewModel.didTapOkAction()
    }
    
}
