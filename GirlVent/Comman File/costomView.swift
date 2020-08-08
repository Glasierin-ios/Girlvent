//
//  costomView.swift
//  GlasierPortfolio
//
//  Created by Glasier Inc on 12/04/18.
//  Copyright © 2018 Glasier Inc. All rights reserved.
//

import Foundation
import UIKit
//MARK:- CustomTextView
class CustomTextView:UITextView{
    
    /// A UIImage value that set LeftImage to the UITextView
    @IBInspectable open var leftImage:UIImage? {
        didSet {
            if (leftImage != nil) {
                self.applyLeftImage(leftImage!)
            }
        }
    }
    
    
    fileprivate func applyLeftImage(_ image: UIImage) {
        let icn : UIImage = image
        let imageView = UIImageView(image: icn)
        imageView.frame = CGRect(x: 0, y: 2.0, width: icn.size.width + 20, height: icn.size.height)
        imageView.contentMode = UIView.ContentMode.center
        //Where self = UItextView
        self.addSubview(imageView)
        self.textContainerInset = UIEdgeInsets(top: icn.size.height / 5  , left: icn.size.width + 10.0 , bottom: 0.0, right: 0.0)
    }
}
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableTableView: UITableView{
}

@IBDesignable
class DesignableImageView: UIImageView{
}

extension UIView {
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    @IBInspectable
                 var maskstoBound: Bool {
                     get {
                         return layer.masksToBounds
                     }
                     set {
                         layer.masksToBounds = newValue
                     }
                 }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    
    
}

