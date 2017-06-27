//
//  FaceView.swift
//  Happiness
//
//  Created by AlexZHOU on 12/06/2017.
//  Copyright © 2017 AlexZHOU. All rights reserved.
//

import UIKit

class FaceView: UIView {

    var lineWidth: CGFloat = 3 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var color: UIColor = UIColor.blue {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var scale: CGFloat = 0.90 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var faceCenter: CGPoint {
        return convert(center, from: superview)
    }
    
    var faceRadius: CGFloat {
        return (min(bounds.size.width , bounds.size.height) / 2) * scale
    }
    
    private enum Eye{
        case Left
        case Right
    }
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left:
            eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right:
            eyeCenter.x += eyeHorizontalSeparation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    private func bezierPathForSmile(frationOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth =  faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(frationOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight )
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
        
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius , startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        
        facePath.stroke()
        
        bezierPathForEye(whichEye: Eye.Left).stroke()
        bezierPathForEye(whichEye: Eye.Right).stroke()
        
        bezierPathForSmile(frationOfMaxSmile: 0.75).stroke()
        
    }
 
    

}
