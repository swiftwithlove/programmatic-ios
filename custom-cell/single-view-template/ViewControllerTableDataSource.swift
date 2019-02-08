//
//  ViewControllerTableDataSource.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-05.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

class ViewControllerTableDataSource: NSObject {
    
    var data = [String]()
    
}

extension ViewControllerTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MyCustomCell.self),
            for: indexPath
        ) as! MyCustomCell
        
        /// Get the item selected at indexPath row
        let i = data[indexPath.row]
        
        // Assign the value to the labels text.
        cell.customTitleLabel.text = i
        cell.customSubtitleLabel.text = "Detail text"
        cell.customImageView.image = UIImage(named: "image")
        return cell
    }
}
