//
//  MyCustomCell.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-08.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    // MARK: - Properties
    
    let customImageView = UIImageView()
    let customTitleLabel = UILabel()
    let customSubtitleLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setup() {
        setupCell()
        setupCustomImageView()
        setupCustomTitleLabel()
        setupCustomSubtitleLabel()
    }
    
    func setupCell() {
        accessoryType = .detailButton
    }
    
    func setupCustomImageView() {
        contentView.addSubview(customImageView)
    }
    
    func setupCustomTitleLabel() {
        customTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(customTitleLabel)
    }
    
    func setupCustomSubtitleLabel() {
        customSubtitleLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(customSubtitleLabel)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Layout
    
    func layout() {
        layoutImageView()
        layoutTitleLabel()
        layoutSubtitleLabel()
    }
    
    func layoutImageView() {
        customImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    func layoutTitleLabel() {
        customTitleLabel.frame = CGRect(
            x: customImageView.frame.maxX + 10,
            y: 20,
            width: 100,
            height: 20
        )
    }
    
    func layoutSubtitleLabel() {
        customSubtitleLabel.frame = CGRect(
            x: customImageView.frame.maxX + 10,
            y: customTitleLabel.frame.maxY + 5,
            width: bounds.size.width - 20,
            height: 16
        )
    }
}
