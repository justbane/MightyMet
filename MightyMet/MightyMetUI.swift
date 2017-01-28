//
//  MightyMetUI.swift
//  MightyMetUI
//
//  Created by Justin Bane on 1/24/17.
//  Copyright © 2017 . All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class MightyMetUI : NSObject {

    //// Cache

    private struct Cache {
        static let red: UIColor = UIColor(red: 0.676, green: 0.073, blue: 0.073, alpha: 1.000)
        static let yellow: UIColor = UIColor(red: 0.987, green: 1.000, blue: 0.000, alpha: 1.000)
        static let fuscia: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.413, alpha: 1.000)
        static let transparent: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.156)
        static let lime: UIColor = UIColor(red: 0.000, green: 1.000, blue: 0.108, alpha: 1.000)
        static let electricBlue: UIColor = UIColor(red: 0.000, green: 0.974, blue: 1.000, alpha: 1.000)
        static let blue: UIColor = UIColor(red: 0.000, green: 0.070, blue: 1.000, alpha: 1.000)
        static let darkBlue: UIColor = MightyMetUI.blue.withBrightness(0.3)
        static let darkRed: UIColor = MightyMetUI.red.withBrightness(0.3)
        static let yellowOrange: UIColor = MightyMetUI.yellow.withHue(0.1)
        static let darkFuscia: UIColor = MightyMetUI.fuscia.withBrightness(0.4)
        static let redYellow: CGGradient = CGGradient(colorsSpace: nil, colors: [MightyMetUI.red.cgColor, MightyMetUI.yellow.cgColor] as CFArray, locations: [0.26, 1])!
    }

    //// Colors

    public dynamic class var red: UIColor { return Cache.red }
    public dynamic class var yellow: UIColor { return Cache.yellow }
    public dynamic class var fuscia: UIColor { return Cache.fuscia }
    public dynamic class var transparent: UIColor { return Cache.transparent }
    public dynamic class var lime: UIColor { return Cache.lime }
    public dynamic class var electricBlue: UIColor { return Cache.electricBlue }
    public dynamic class var blue: UIColor { return Cache.blue }
    public dynamic class var darkBlue: UIColor { return Cache.darkBlue }
    public dynamic class var darkRed: UIColor { return Cache.darkRed }
    public dynamic class var yellowOrange: UIColor { return Cache.yellowOrange }
    public dynamic class var darkFuscia: UIColor { return Cache.darkFuscia }

    //// Gradients

    public dynamic class var redYellow: CGGradient { return Cache.redYellow }

    //// Drawing Methods

    public dynamic class func drawMultiSelector(frame: CGRect = CGRect(x: 0, y: 0, width: 345, height: 345), bPMAngle: CGFloat = 0, pitchAngle: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Group
        //// Track
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 173.5, y: frame.minY + 55.3))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 116, y: frame.minY + 70.65), controlPoint1: CGPoint(x: frame.minX + 152.56, y: frame.minY + 55.3), controlPoint2: CGPoint(x: frame.minX + 132.92, y: frame.minY + 60.89))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 58.3, y: frame.minY + 170.5), controlPoint1: CGPoint(x: frame.minX + 81.51, y: frame.minY + 90.56), controlPoint2: CGPoint(x: frame.minX + 58.3, y: frame.minY + 127.82))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 173.5, y: frame.minY + 285.7), controlPoint1: CGPoint(x: frame.minX + 58.3, y: frame.minY + 234.12), controlPoint2: CGPoint(x: frame.minX + 109.88, y: frame.minY + 285.7))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 288.7, y: frame.minY + 170.5), controlPoint1: CGPoint(x: frame.minX + 237.12, y: frame.minY + 285.7), controlPoint2: CGPoint(x: frame.minX + 288.7, y: frame.minY + 234.12))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 173.5, y: frame.minY + 55.3), controlPoint1: CGPoint(x: frame.minX + 288.7, y: frame.minY + 106.88), controlPoint2: CGPoint(x: frame.minX + 237.12, y: frame.minY + 55.3))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 333.5, y: frame.minY + 170.5))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 173.5, y: frame.minY + 330.5), controlPoint1: CGPoint(x: frame.minX + 333.5, y: frame.minY + 258.87), controlPoint2: CGPoint(x: frame.minX + 261.87, y: frame.minY + 330.5))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 13.5, y: frame.minY + 170.5), controlPoint1: CGPoint(x: frame.minX + 85.13, y: frame.minY + 330.5), controlPoint2: CGPoint(x: frame.minX + 13.5, y: frame.minY + 258.87))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 77.16, y: frame.minY + 42.74), controlPoint1: CGPoint(x: frame.minX + 13.5, y: frame.minY + 118.31), controlPoint2: CGPoint(x: frame.minX + 38.49, y: frame.minY + 71.95))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 173.5, y: frame.minY + 10.5), controlPoint1: CGPoint(x: frame.minX + 103.96, y: frame.minY + 22.5), controlPoint2: CGPoint(x: frame.minX + 137.33, y: frame.minY + 10.5))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 333.5, y: frame.minY + 170.5), controlPoint1: CGPoint(x: frame.minX + 261.87, y: frame.minY + 10.5), controlPoint2: CGPoint(x: frame.minX + 333.5, y: frame.minY + 82.13))
        bezierPath.close()
        context.saveGState()
        bezierPath.addClip()
        let bezierBounds = bezierPath.cgPath.boundingBoxOfPath
        context.drawLinearGradient(MightyMetUI.redYellow,
            start: CGPoint(x: bezierBounds.midX, y: bezierBounds.minY),
            end: CGPoint(x: bezierBounds.midX, y: bezierBounds.maxY),
            options: [])
        context.restoreGState()




        //// PitchHandle Drawing
        context.saveGState()
        context.translateBy(x: frame.minX + 173.49, y: frame.minY + 170.13)
        context.rotate(by: -pitchAngle * CGFloat.pi/180)

        let pitchHandlePath = UIBezierPath(ovalIn: CGRect(x: -22.17, y: -158.4, width: 44.54, height: 42.62))
        MightyMetUI.transparent.setFill()
        pitchHandlePath.fill()
        MightyMetUI.lime.setStroke()
        pitchHandlePath.lineWidth = 3.5
        pitchHandlePath.stroke()

        context.restoreGState()


        //// BPMHandle Drawing
        context.saveGState()
        context.translateBy(x: frame.minX + 173.5, y: frame.minY + 170.86)
        context.rotate(by: -bPMAngle * CGFloat.pi/180)

        let bPMHandlePath = UIBezierPath(ovalIn: CGRect(x: -19.72, y: 115.27, width: 44.8, height: 44.79))
        MightyMetUI.transparent.setFill()
        bPMHandlePath.fill()
        MightyMetUI.electricBlue.setStroke()
        bPMHandlePath.lineWidth = 3.5
        bPMHandlePath.stroke()

        context.restoreGState()
    }

    public dynamic class func drawBPMSelector(frame: CGRect = CGRect(x: 0, y: 0, width: 310, height: 310), bPMAngle: CGFloat = 0, bPMText: String = "0") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!


        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.8)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 5


        //// Subframes
        let group: CGRect = CGRect(x: frame.minX + 11, y: frame.minY + frame.height - 299, width: 288, height: 288)


        //// Group
        //// Track
        context.saveGState()
        context.translateBy(x: group.minX + 144, y: group.minY + 144)



        //// Bezier Drawing
        context.saveGState()

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: -103.68))
        bezierPath.addCurve(to: CGPoint(x: -51.75, y: -89.86), controlPoint1: CGPoint(x: -18.85, y: -103.68), controlPoint2: CGPoint(x: -36.52, y: -98.65))
        bezierPath.addCurve(to: CGPoint(x: -103.68, y: -0), controlPoint1: CGPoint(x: -82.79, y: -71.95), controlPoint2: CGPoint(x: -103.68, y: -38.41))
        bezierPath.addCurve(to: CGPoint(x: -0, y: 103.68), controlPoint1: CGPoint(x: -103.68, y: 57.26), controlPoint2: CGPoint(x: -57.26, y: 103.68))
        bezierPath.addCurve(to: CGPoint(x: 103.68, y: 0), controlPoint1: CGPoint(x: 57.26, y: 103.68), controlPoint2: CGPoint(x: 103.68, y: 57.26))
        bezierPath.addCurve(to: CGPoint(x: 0, y: -103.68), controlPoint1: CGPoint(x: 103.68, y: -57.26), controlPoint2: CGPoint(x: 57.26, y: -103.68))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 144, y: 0))
        bezierPath.addCurve(to: CGPoint(x: -0, y: 144), controlPoint1: CGPoint(x: 144, y: 79.53), controlPoint2: CGPoint(x: 79.53, y: 144))
        bezierPath.addCurve(to: CGPoint(x: -144, y: -0), controlPoint1: CGPoint(x: -79.53, y: 144), controlPoint2: CGPoint(x: -144, y: 79.53))
        bezierPath.addCurve(to: CGPoint(x: -86.7, y: -114.98), controlPoint1: CGPoint(x: -144, y: -46.97), controlPoint2: CGPoint(x: -121.51, y: -88.7))
        bezierPath.addCurve(to: CGPoint(x: 0, y: -144), controlPoint1: CGPoint(x: -62.59, y: -133.2), controlPoint2: CGPoint(x: -32.55, y: -144))
        bezierPath.addCurve(to: CGPoint(x: 144, y: 0), controlPoint1: CGPoint(x: 79.53, y: -144), controlPoint2: CGPoint(x: 144, y: -79.53))
        bezierPath.close()
        context.saveGState()
        bezierPath.addClip()
        context.drawLinearGradient(MightyMetUI.redYellow, start: CGPoint(x: -0, y: -144), end: CGPoint(x: 0, y: 144), options: [])
        context.restoreGState()

        context.restoreGState()



        context.restoreGState()


        //// Handle
        context.saveGState()
        context.translateBy(x: group.minX + 144, y: group.minY + 144)

        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)


        //// BPMHandle Drawing
        context.saveGState()
        context.rotate(by: -(bPMAngle + 90) * CGFloat.pi/180)

        let bPMHandlePath = UIBezierPath(ovalIn: CGRect(x: -19.84, y: 105.64, width: 38.72, height: 38.17))
        MightyMetUI.transparent.setFill()
        bPMHandlePath.fill()
        MightyMetUI.electricBlue.setStroke()
        bPMHandlePath.lineWidth = 3.5
        bPMHandlePath.stroke()

        context.restoreGState()


        context.endTransparencyLayer()

        context.restoreGState()


        //// TextLabel
        //// BPM Drawing
        let bPMRect = CGRect(x: group.minX + 53, y: group.minY + 113, width: 110, height: 61)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        let bPMStyle = NSMutableParagraphStyle()
        bPMStyle.alignment = .right
        let bPMFontAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Roman", size: 60)!, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: bPMStyle]

        let bPMTextHeight: CGFloat = bPMText.boundingRect(with: CGSize(width: bPMRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: bPMFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: bPMRect)
        bPMText.draw(in: CGRect(x: bPMRect.minX, y: bPMRect.minY + (bPMRect.height - bPMTextHeight) / 2, width: bPMRect.width, height: bPMTextHeight), withAttributes: bPMFontAttributes)
        context.restoreGState()
        context.restoreGState()



        //// BPM Label Drawing
        let bPMLabelRect = CGRect(x: group.minX + 168, y: group.minY + 119, width: 43, height: 21)
        let bPMLabelTextContent = "BPM"
        let bPMLabelStyle = NSMutableParagraphStyle()
        bPMLabelStyle.alignment = .left
        let bPMLabelFontAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: UIFont.labelFontSize)!, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: bPMLabelStyle]

        let bPMLabelTextHeight: CGFloat = bPMLabelTextContent.boundingRect(with: CGSize(width: bPMLabelRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: bPMLabelFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: bPMLabelRect)
        bPMLabelTextContent.draw(in: CGRect(x: bPMLabelRect.minX, y: bPMLabelRect.minY + (bPMLabelRect.height - bPMLabelTextHeight) / 2, width: bPMLabelRect.width, height: bPMLabelTextHeight), withAttributes: bPMLabelFontAttributes)
        context.restoreGState()
    }

    public dynamic class func drawHertzSelector(frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), pitchAngle: CGFloat = 0, hertzText: String = "0") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let purple = UIColor(red: 0.462, green: 0.000, blue: 1.000, alpha: 1.000)

        //// Gradient Declarations
        let bluePink = CGGradient(colorsSpace: nil, colors: [purple.cgColor, MightyMetUI.fuscia.cgColor] as CFArray, locations: [0, 1])!

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.8)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 5

        //// Track
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 100.5, y: frame.minY + 39))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 73.41, y: frame.minY + 45.39), controlPoint1: CGPoint(x: frame.minX + 90.76, y: frame.minY + 39), controlPoint2: CGPoint(x: frame.minX + 81.56, y: frame.minY + 41.3))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 40, y: frame.minY + 99.5), controlPoint1: CGPoint(x: frame.minX + 53.6, y: frame.minY + 55.32), controlPoint2: CGPoint(x: frame.minX + 40, y: frame.minY + 75.82))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 100.5, y: frame.minY + 160), controlPoint1: CGPoint(x: frame.minX + 40, y: frame.minY + 132.91), controlPoint2: CGPoint(x: frame.minX + 67.09, y: frame.minY + 160))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 161, y: frame.minY + 99.5), controlPoint1: CGPoint(x: frame.minX + 133.91, y: frame.minY + 160), controlPoint2: CGPoint(x: frame.minX + 161, y: frame.minY + 132.91))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 100.5, y: frame.minY + 39), controlPoint1: CGPoint(x: frame.minX + 161, y: frame.minY + 66.09), controlPoint2: CGPoint(x: frame.minX + 133.91, y: frame.minY + 39))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 189, y: frame.minY + 100))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 100, y: frame.minY + 189), controlPoint1: CGPoint(x: frame.minX + 189, y: frame.minY + 149.15), controlPoint2: CGPoint(x: frame.minX + 149.15, y: frame.minY + 189))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 11, y: frame.minY + 100), controlPoint1: CGPoint(x: frame.minX + 50.85, y: frame.minY + 189), controlPoint2: CGPoint(x: frame.minX + 11, y: frame.minY + 149.15))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 50, y: frame.minY + 26.36), controlPoint1: CGPoint(x: frame.minX + 11, y: frame.minY + 69.38), controlPoint2: CGPoint(x: frame.minX + 26.46, y: frame.minY + 42.38))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 100, y: frame.minY + 11), controlPoint1: CGPoint(x: frame.minX + 64.25, y: frame.minY + 16.67), controlPoint2: CGPoint(x: frame.minX + 81.46, y: frame.minY + 11))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 189, y: frame.minY + 100), controlPoint1: CGPoint(x: frame.minX + 149.15, y: frame.minY + 11), controlPoint2: CGPoint(x: frame.minX + 189, y: frame.minY + 50.85))
        bezierPath.close()
        context.saveGState()
        bezierPath.addClip()
        let bezierBounds = bezierPath.cgPath.boundingBoxOfPath
        context.drawLinearGradient(bluePink,
            start: CGPoint(x: bezierBounds.midX, y: bezierBounds.maxY),
            end: CGPoint(x: bezierBounds.midX, y: bezierBounds.minY),
            options: [])
        context.restoreGState()




        //// Handle
        //// BPMHandle Drawing
        context.saveGState()
        context.translateBy(x: frame.minX + 100, y: frame.minY + 100)
        context.rotate(by: -(pitchAngle + 90) * CGFloat.pi/180)

        let bPMHandlePath = UIBezierPath(ovalIn: CGRect(x: -13.84, y: 61, width: 27.84, height: 27.82))
        MightyMetUI.transparent.setFill()
        bPMHandlePath.fill()
        MightyMetUI.electricBlue.setStroke()
        bPMHandlePath.lineWidth = 3.5
        bPMHandlePath.stroke()

        context.restoreGState()




        //// Labels
        //// Hertz Value Drawing
        let hertzValueRect = CGRect(x: frame.minX + 57, y: frame.minY + 65, width: 87, height: 49)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        let hertzValueStyle = NSMutableParagraphStyle()
        hertzValueStyle.alignment = .center
        let hertzValueFontAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Roman", size: 40)!, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: hertzValueStyle]

        let hertzValueTextHeight: CGFloat = hertzText.boundingRect(with: CGSize(width: hertzValueRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: hertzValueFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: hertzValueRect)
        hertzText.draw(in: CGRect(x: hertzValueRect.minX, y: hertzValueRect.minY + (hertzValueRect.height - hertzValueTextHeight) / 2, width: hertzValueRect.width, height: hertzValueTextHeight), withAttributes: hertzValueFontAttributes)
        context.restoreGState()
        context.restoreGState()



        //// Herts Label Drawing
        let hertsLabelRect = CGRect(x: frame.minX + 72, y: frame.minY + 114, width: 56, height: 21)
        let hertsLabelTextContent = "Hz"
        let hertsLabelStyle = NSMutableParagraphStyle()
        hertsLabelStyle.alignment = .center
        let hertsLabelFontAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Light", size: 20)!, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: hertsLabelStyle]

        let hertsLabelTextHeight: CGFloat = hertsLabelTextContent.boundingRect(with: CGSize(width: hertsLabelRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: hertsLabelFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: hertsLabelRect)
        hertsLabelTextContent.draw(in: CGRect(x: hertsLabelRect.minX, y: hertsLabelRect.minY + (hertsLabelRect.height - hertsLabelTextHeight) / 2, width: hertsLabelRect.width, height: hertsLabelTextHeight), withAttributes: hertsLabelFontAttributes)
        context.restoreGState()
    }

}



extension UIColor {
    func withHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func withSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1, brightness: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func withBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, alpha: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func withAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1, saturation: CGFloat = 1, brightness: CGFloat = 1
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func highlight(withLevel highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func shadow(withLevel shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1, alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}
