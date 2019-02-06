//
//  ViewControllerB.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-06.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

private struct Constants {
    static let fontSize: CGFloat = 36.0
}

class ViewControllerB: UIViewController {
    
    // MARK: - Properties
    
    var dataItem: String? = .none
    
    let dataLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupLabel()
        setupNavigationBar()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func setupLabel() {
        dataLabel.textAlignment = .center
        dataLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        view.addSubview(dataLabel)
        
        guard let item = dataItem else {
            return
        }
        dataLabel.text = item
    }
    
    func setupNavigationBar() {
        title = "Screen B"
    }
    
    // MARK: - Layout
    
    func layout() {
        layoutLabel()
    }
    
    func layoutLabel() {
        dataLabel.frame = CGRect(
            x: (view.bounds.size.width / 2) - 50,
            y: (view.bounds.size.height / 2) - 20,
            width: 100,
            height: 40
        )
    }
}
