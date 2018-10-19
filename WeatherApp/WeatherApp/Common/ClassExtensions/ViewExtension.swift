//
//  ViewExtension.swift
//  WeatherApp
//
//  Created by Pavan on 19/10/18.
//  Copyright © 2018 Pavan Shisode. All rights reserved.
//

import UIKit

extension UIView {
    
    func circularView() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 2
    }
}

extension UIView {
    /**
     This will give the x coordinate of the view
     
     - Returns: The x Coordinate
     */
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /**
     This will give the y coordinate of the view
     
     - Returns: The y Coordinate
     */
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    /**
     This will give the width of the view
     
     - Returns: The width
     */
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    /**
     This will give the height of the view
     
     - Returns: The height
     */
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    /**
     This will give the size of the view
     
     - Returns: The size
     */
    func size() -> CGSize {
        return self.frame.size
    }
    
    /**
     This will set the height of the view
     
     - Parameter width: The width of the view to be modified into
     */
    func setHeight(_ height: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    /**
     This will set the width of the view
     
     - Parameter width: The width of the view to be modified into
     */
    func setWidth(_ width: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
    }
    
    /**
     This will set the x coordinate of the view
     
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setX(_ x: CGFloat) {
        
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    /**
     This will set the y coordinate of the view
     
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setY(_ y: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.size.height)
    }
}
