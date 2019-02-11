//
//  ViewControllerB.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-06.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

protocol ViewControllerBDelegate: class {
    func didPressSave(section: TableSection, string: String)
}

private struct Constants {
    static let fontSize: CGFloat = 36.0
}

class ViewControllerB: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ViewControllerBDelegate?
    
    let segment = UISegmentedControl()
    let dataTextField = UITextField()
    
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
        setupTextField()
        setupSegmentedControl()
        setupNavigationBar()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func setupTextField() {
        dataTextField.textAlignment = .center
        dataTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        dataTextField.placeholder = "Enter text..."
        dataTextField.becomeFirstResponder()
        view.addSubview(dataTextField)
    }
    
    func setupNavigationBar() {
        title = "Screen B"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save)
        )
        navigationItem.titleView = segment
        navigationController?.navigationBar.style()
    }
    
    func setupSegmentedControl() {
        segment.insertSegment(
            withTitle: String(TableSection.top.rawValue),
            at: TableSection.top.rawValue,
            animated: false
        )
        segment.insertSegment(
            withTitle: String(TableSection.middle.rawValue),
            at: TableSection.middle.rawValue,
            animated: false
        )
        segment.insertSegment(
            withTitle: String(TableSection.bottom.rawValue),
            at: TableSection.bottom.rawValue,
            animated: false
        )
    }
    
    // MARK: - Layout
    
    func layout() {
        layoutTextField()
    }
    
    func layoutTextField() {
        dataTextField.frame = CGRect(
            x: (view.bounds.size.width / 2) - 100,
            y: 160,
            width: 200,
            height: 40
        )
    }
    
    // MARK: - Selectors
    
    @objc func save() {
        
        guard
            let s = dataTextField.text,
            let t = TableSection(rawValue: segment.selectedSegmentIndex)
        else {
            return
        }
        
        delegate?.didPressSave(section: t, string: s)
        navigationController?.popViewController(animated: true)
    }
}
