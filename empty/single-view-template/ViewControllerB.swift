//
//  ViewControllerB.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-06.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

protocol ViewControllerBDelegate: class {
    func didPressSave(section: TableSection, item: TableSectionItem)
}

private struct Constants {
    static let fontSize: CGFloat = 14.0
    static let padding: CGFloat = 20.0
    static let dimension: CGFloat = 40.0
}

class ViewControllerB: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ViewControllerBDelegate?
    
    let segment = UISegmentedControl()
    let dataTextField = UITextField()
    let imageButton = UIButton()
    
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
        setupImageButton()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    func setupTextField() {
        dataTextField.textAlignment = .center
        dataTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        dataTextField.placeholder = "Enter text..."
        dataTextField.becomeFirstResponder()
        
        dataTextField.layer.borderWidth = 1
        dataTextField.layer.borderColor = UIColor.blue.cgColor
        view.addSubview(dataTextField)
    }
    
    func setupNavigationBar() {
        title = "Create todo"
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
            withTitle: sectionTitle(index: TableSection.top.rawValue),
            at: TableSection.top.rawValue,
            animated: false
        )
        segment.insertSegment(
            withTitle: sectionTitle(index: TableSection.middle.rawValue),
            at: TableSection.middle.rawValue,
            animated: false
        )
        segment.insertSegment(
            withTitle: sectionTitle(index: TableSection.bottom.rawValue),
            at: TableSection.bottom.rawValue,
            animated: false
        )
    }
    
    func setupImageButton() {
        imageButton.setImage(UIImage(named: "camera"), for: .normal)
        imageButton.addTarget(self, action: #selector(openPhotoLibrary), for: UIControl.Event.touchUpInside)
        view.addSubview(imageButton)
    }
    
    // MARK: - Layout
    
    func layout() {
        layoutTextField()
        layoutImageButton()
    }
    
    func layoutTextField() {
        
        guard let nMaxY = navigationController?.navigationBar.frame.maxY else {
            return
        }
        
        dataTextField.frame = CGRect(
            x: Constants.padding,
            y: nMaxY + Constants.padding,
            width: 200,
            height: Constants.dimension
        )
    }
    
    func layoutImageButton() {
        imageButton.frame = CGRect(
            x: dataTextField.frame.maxX + Constants.padding,
            y: dataTextField.frame.minY,
            width: Constants.dimension,
            height: Constants.dimension
        )
    }
    
    // MARK: - Selectors
    
    @objc func save() {
        
        guard
            let s = dataTextField.text,
            let t = TableSection(rawValue: segment.selectedSegmentIndex),
            let imageView = imageButton.imageView,
            let image = imageView.image
        else {
            return
        }
        
        let i = TableSectionItem(image: image, string: s)
        delegate?.didPressSave(section: t, item: i)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func openPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension ViewControllerB: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No selected image")
            return
        }
        
        imageButton.setImage(image, for: .normal)
    }
}
