//
//  Gradients.swift
//  MightyMet
//
//  Created by Justin Bane on 1/24/17.
//  Copyright © 2017 Justin Bane. All rights reserved.
//

import Foundation
import UIKit

struct Gradients {
    
    let blueColor: UIColor
    let darkblueColor: UIColor
    let orangeColor: UIColor
    let darkorangeColor: UIColor
    let fusciaColor: UIColor
    let darkFusciaColor: UIColor
    
    var colorGrad: CAGradientLayer
    
    init(colorString: String) {
        
        blueColor = MightyMetUI.midBlue
        darkblueColor = MightyMetUI.darkBlue
        
        orangeColor = MightyMetUI.yellow
        darkorangeColor = MightyMetUI.yellowOrange
        
        fusciaColor = MightyMetUI.fuscia
        darkFusciaColor = MightyMetUI.darkFuscia
        
        colorGrad = CAGradientLayer()
        
        switch(colorString) {
            
        case "blue":
            colorGrad = getGradientLayer(blueColor, bottomColor: darkblueColor)
            
        case "orange":
            colorGrad = getGradientLayer(orangeColor, bottomColor: darkorangeColor)
            
        case "fuscia":
            colorGrad = getGradientLayer(fusciaColor, bottomColor: darkFusciaColor)
            
        default:
            colorGrad = getGradientLayer(blueColor, bottomColor: darkblueColor)
            
        }
        
    }
    
    
    func getGradientLayer(_ topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
        
        
        let gradientColors: [AnyObject] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
        
    }
    
    func getGradient() -> CAGradientLayer {
        return colorGrad
    }
    
    // End class
}
