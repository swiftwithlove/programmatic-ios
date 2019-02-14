//
//  ViewController.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-04.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {

    // MARK: - Properties
    
    let tableViewDataSource = ViewControllerTableDataSource()
    let tableEmptyView = EmptyView(frame: CGRect.zero)
    let tableView = UITableView()
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupNavigationBar()
        setupTableView()
        setupEmptyView()
        
        checkIsEmpty()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.blue
    }
    
    func setupNavigationBar() {
        title = "Todos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showScreenB))
        navigationController?.navigationBar.style()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        tableView.register(
            MyCustomCell.self,
            forCellReuseIdentifier: String(describing: MyCustomCell.self)
        )
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    func setupEmptyView() {
        view.addSubview(tableEmptyView)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    
    // MARK: - Layout
    
    func layout() {
        layoutTableView()
        layoutEmptyView()
    }
    
    func layoutTableView() {
        tableView.frame = view.bounds
    }
    
    func layoutEmptyView() {
        tableEmptyView.frame = view.bounds
    }
    
    // MARK: - Selectors
    
    @objc func showScreenB() {
        let vc = ViewControllerB()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Method
    func checkIsEmpty() {
        guard
            let high = tableViewDataSource.data[TableSection.top.rawValue],
            let middle = tableViewDataSource.data[TableSection.middle.rawValue],
            let bottom = tableViewDataSource.data[TableSection.bottom.rawValue]
        else {
            print("Could not obtain values from tableViewDataSource")
            return
        }
        tableEmptyView.isHidden = !(high.isEmpty && middle.isEmpty && bottom.isEmpty)
    }
}

// MARK: - UITableViewDelegate

extension ViewControllerA: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ViewControllerB(), animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - ViewControllerBDelegate

extension ViewControllerA: ViewControllerBDelegate {
    
    func didPressSave(section: TableSection, item: TableSectionItem) {
        
        // Grab the values (the array at the section we care about)
        guard var values = tableViewDataSource.data[section.rawValue] else {
            return
        }
        
        // insert the string into the values array
        values.append(item)
        
        // replace the array that is being pointed to by that key.
        tableViewDataSource.data[section.rawValue] = values
        
        // show empty screen if arrays have no data
        
        checkIsEmpty()
        
        // reload the table data.
        tableView.reloadData()
    }
}

