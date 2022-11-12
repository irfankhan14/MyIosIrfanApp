//
//  CustomUITextField.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 12/11/22.
//

import Foundation
import UIKit

class CustomUITextField: UITextField {
    
    var padding : CGFloat = 32
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLeftImage(image: UIImage, tintColor: UIColor!){
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 10, y: self.frame.height/2-10, width: 20, height: 20))
        leftView.tintColor = tintColor
        leftView.image = image
        self.addSubview(leftView)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let bounds = CGRect(x: padding, y: 0 , width: bounds.width, height: bounds.height)
        
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let bounds = CGRect(x:  self.padding, y: 0 , width: bounds.width, height: bounds.height)
        
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let bounds = CGRect(x: self.padding, y: 0 , width: bounds.width, height: bounds.height)
        
        return bounds
    }
}
