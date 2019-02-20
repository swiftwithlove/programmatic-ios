//
//  EmptyView.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-14.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    // MARK: - Properties
    let label = UILabel()
    
    // MARK: - Setup
    
    func setup() {
        backgroundColor = UIColor.orange
        setupLabel()
    }
    
    func setupLabel() {
        label.text = "Add your first todo."
        label.textAlignment = .center
        addSubview(label)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        layoutLabel()
    }
    
    func layoutLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        label.center = self.center
    }
}
