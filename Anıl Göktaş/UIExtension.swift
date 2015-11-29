//
//  View.swift
//  Anıl Göktaş
//
//  Created by Anıl Göktaş on 4/24/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView { }

@IBDesignable
class Button: UIButton { }

@IBDesignable
class ImageView: UIImageView { }

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(CGColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    
}