//
//  ViewController.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-04.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

private struct Constants {
    
    static let rowHeight: CGFloat = 100.0
}

class ViewControllerA: UIViewController {

    // MARK: - Properties
    
    let tableViewDataSource = ViewControllerTableDataSource()
    let tableEmptyView = EmptyView(frame: CGRect.zero)
    let tableView = UITableView()
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupNavigationBar()
        setupTableViewDataSource()
        setupTableView()
        setupEmptyView()
        setupNotifications()
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
    
    func setupTableViewDataSource() {
        tableViewDataSource.data = load()
        tableViewDataSource.delegate = self
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
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveTableViewDataSource),
            name: NSNotification.Name("SAVE_DATA"),
            object: nil
        )
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
    
    @objc func saveTableViewDataSource() {
        print(String(describing: save(data: tableViewDataSource.data)))
    }
    
    func load() -> [Int: [TableSectionItem]] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "data") {
            do {
                return try decoder.decode(Dictionary<Int, [TableSectionItem]>.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return [
            TableSection.top.rawValue : [TableSectionItem](),
            TableSection.middle.rawValue : [TableSectionItem](),
            TableSection.bottom.rawValue : [TableSectionItem]()
        ]
    }
    
    func save(data: [Int: [TableSectionItem]]) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: "data")
            return true
        }
        return false
    }
}

// MARK: - UITableViewDelegate

extension ViewControllerA: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let k = Array(tableViewDataSource.data.keys.sorted())[indexPath.section]
        if let v = tableViewDataSource.data[k] {
            let item = v[indexPath.row]
            let vc = ViewControllerB()
            vc.section = indexPath.section
            vc.item = item
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

// MARK: - ViewControllerBDelegate

extension ViewControllerA: ViewControllerBDelegate {
    
    func didPressSave(section: TableSection, item: TableSectionItem) {
        
        guard
            var t = tableViewDataSource.data[TableSection.top.rawValue],
            var m = tableViewDataSource.data[TableSection.middle.rawValue],
            var b = tableViewDataSource.data[TableSection.bottom.rawValue]
        else {
            return
        }
        
        if let index = t.index(where: { $0.created == item.created }) {
            t.remove(at: index)
            tableViewDataSource.data[TableSection.top.rawValue] = t
        }
        if let index = m.index(where: { $0.created == item.created }) {
            m.remove(at: index)
            tableViewDataSource.data[TableSection.middle.rawValue] = m
        }
        if let index = b.index(where: { $0.created == item.created }) {
            b.remove(at: index)
            tableViewDataSource.data[TableSection.bottom.rawValue] = b
        }
        
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

extension ViewControllerA: ViewControllerTableDataSourceDelegate {
    
    func didPressDelete(indexPath: IndexPath) {
        checkIsEmpty()
    }
}
