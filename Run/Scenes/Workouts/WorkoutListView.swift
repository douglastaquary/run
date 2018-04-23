//
//  ListView.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class WorkoutListView: UIView {

    let tableView: UITableView
    let style: StyleProvider = Style()
    
    public var viewModel: WorkoutListViewModelProtocol = WorkoutListViewModel() {
        didSet {
            update()
        }
    }
    
    override public init(frame: CGRect) {
        tableView = UITableView(frame: frame, style: .grouped)
        super.init(frame: frame)
        setUp()
        update()
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
        
        let backgroundColor = style.backgroundColor
        let grid = style.grid
        self.backgroundColor = backgroundColor
        contentView.backgroundColor = backgroundColor
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        tableView.allowsSelection = false
        
        tableView.register(WorkoutViewCell.self, forCellReuseIdentifier: "\(WorkoutViewCell.self)")
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = grid * 11
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = backgroundColor
        
        tableView.separatorStyle = .none

        
    }
    
    
    func update() {
        tableView.reloadData()
//        if let emptyListViewModel = viewModel.emptyListViewModel {
////            let backgroundView = TitleDescriptionView()
////            backgroundView.viewModel = emptyListViewModel
////            tableView.backgroundView = backgroundView
//        } else {
//            tableView.backgroundView = nil
//        }
    }
    
    @objc func buttonTap() {
        //viewModel.deleteAction(<#UInt#>)
    }
    
}

extension WorkoutListView: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return Int(viewModel.items)
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WorkoutViewCell.self)",
                                                 for: indexPath) as! WorkoutViewCell
        
        //cell.configure(with: viewModel.data(UInt(indexPath.row)))
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView,
                          canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        viewModel.deleteAction(UInt(indexPath.item))
    }
    

}
