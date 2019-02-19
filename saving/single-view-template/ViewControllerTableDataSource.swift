//
//  ViewControllerTableDataSource.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-05.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

protocol ViewControllerTableDataSourceDelegate: class {
    func didPressDelete(indexPath: IndexPath)
}

enum TableSection: Int {
    case top, middle, bottom
}

class ViewControllerTableDataSource: NSObject {
    
    weak var delegate: ViewControllerTableDataSourceDelegate?
    
    var data: [Int: [TableSectionItem]] = [:]
}

extension ViewControllerTableDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let k = Array(data.keys.sorted())[section]
        if let v = data[k] {
            return v.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MyCustomCell.self),
            for: indexPath
        ) as! MyCustomCell
        
        let k = Array(data.keys.sorted())[indexPath.section]
        if let v = data[k] {
            let item = v[indexPath.row]
            cell.customTitleLabel.text = item.string
            cell.customImageView.image = UIImage(data: item.image)
            cell.customSubtitleLabel.text = item.created
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle(index: Array(data.keys.sorted())[section])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            /// Remove the object from our data
            let k = Array(data.keys.sorted())[indexPath.section]
            if var v = data[k] {
                v.remove(at: indexPath.row)
                data[k] = v
            }

            delegate?.didPressDelete(indexPath: indexPath)
            
            /// tableview delete the rows.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
