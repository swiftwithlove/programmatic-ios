//
//  ViewControllerTableDataSource.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-05.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

enum TableSection: Int {
    case top, middle, bottom
}

class ViewControllerTableDataSource: NSObject {
    
    var data = [
        TableSection.top.rawValue : ["Test"],
        TableSection.middle.rawValue : ["Test"],
        TableSection.bottom.rawValue : ["Test"]
    ]
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
            cell.customTitleLabel.text = v[indexPath.row]
        }
        // Assign the value to the labels text.
        cell.customSubtitleLabel.text = "Detail text"
        cell.customImageView.image = UIImage(named: "image")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(Array(data.keys.sorted())[section])
    }
}
