//
//  CustomField.swift
//  weWrk
//
//  Created by luis castillo on 2/17/17.
//  Copyright © 2017 luis castillo. All rights reserved.
//

import UIKit

class CustomField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 25, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 25, dy: 5)
    }
}
