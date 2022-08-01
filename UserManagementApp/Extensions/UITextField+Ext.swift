//
//  UITextField+Ext.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation
import UIKit

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
