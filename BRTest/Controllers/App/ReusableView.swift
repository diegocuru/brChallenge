//
//  ReusableView.swift
//  BRTest
//
//  Created by Diego Curumaco on 3/10/21.
//
import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

// MARK: - Extensions

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
