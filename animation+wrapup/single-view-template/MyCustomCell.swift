//
//  MyCustomCell.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-08.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

private struct Constants {
    static let boldFontSize: CGFloat = 16.0
    static let regularFontSize: CGFloat = 14.0
    static let dimension: CGFloat = 100.0
    static let padding: CGFloat = 10.0
    static let subtitleHeight: CGFloat = 16.0
}

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
        customTitleLabel.font = UIFont.boldSystemFont(ofSize: Constants.boldFontSize)
        contentView.addSubview(customTitleLabel)
    }
    
    func setupCustomSubtitleLabel() {
        customSubtitleLabel.font = UIFont.systemFont(ofSize: Constants.regularFontSize)
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
        customImageView.frame = CGRect(x: 0, y: 0, width: Constants.dimension, height: Constants.dimension)
    }
    
    func layoutTitleLabel() {
        customTitleLabel.frame = CGRect(
            x: customImageView.frame.maxX + Constants.padding,
            y: Constants.padding * 2,
            width: Constants.dimension,
            height: Constants.padding * 2
        )
    }
    
    func layoutSubtitleLabel() {
        customSubtitleLabel.frame = CGRect(
            x: customImageView.frame.maxX + Constants.padding,
            y: customTitleLabel.frame.maxY + (Constants.padding / 2),
            width: bounds.size.width - Constants.padding,
            height: Constants.subtitleHeight
        )
    }
}
