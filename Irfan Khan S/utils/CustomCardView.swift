//
//  CustomCardView.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 21/01/23.
//

import Foundation
import UIKit

@IBDesignable class CustomCardView: UIView {
    
    override func layoutSubviews() {
        
        backgroundColor = .white
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
        
    }
    
}
