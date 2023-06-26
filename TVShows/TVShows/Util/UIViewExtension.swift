//
//  UIViewExtension.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
    
    func applyShadow() {
        layer.cornerRadius = 8.0
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
