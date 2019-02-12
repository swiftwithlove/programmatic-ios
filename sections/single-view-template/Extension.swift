//
//  Extension.swift
//  single-view-template
//
//  Created by Adam Dahan on 2019-02-10.
//  Copyright © 2019 Adam. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func style() {
        prefersLargeTitles = true
        tintColor = UIColor.white
        barTintColor = UIColor.blue
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension NSObject {
    
    func sectionTitle(index: Int) -> String {
        switch index {
        case 0: return "High"
        case 1: return "Medium"
        case 2: return "Low"
        default:
            return ""
        }
    }
}
