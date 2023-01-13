//
//  UIView+Extension.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

public extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = false
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = false
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = false
    }
}
