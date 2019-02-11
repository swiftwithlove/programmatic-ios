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
