//
//  Nameable.swift
//  AppUIKit
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import  UIKit

public protocol Nameable {
    static var stringName: String { get }
}

extension Nameable {
    public static var stringName: String {
        return String(describing: self)
    }
}

extension UIView: Nameable {}
extension UIViewController: Nameable {}
