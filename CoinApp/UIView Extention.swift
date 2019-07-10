//
//  UIView Extention.swift
//  CoinApp
//
//  Created by ATAKAN on 6.07.2019.
//  Copyright © 2019 Xicy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func setGradientBackground(gradients:[UIColor],start:CGPoint,end:CGPoint){
        let gradientLayer = CAGradientLayer()
        if(self.superview != nil){
            gradientLayer.frame = self.superview!.bounds}
        else{
            gradientLayer.frame = self.bounds
        }
         
        gradientLayer.colors = gradients.map({ (UIColor) -> CGColor in return UIColor.cgColor })
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init()
    }
}
