//
//  HappinessViewController.swift
//  Happiness
//
//  Created by AlexZHOU on 12/06/2017.
//  Copyright © 2017 AlexZHOU. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    var happiness: Int = 70 {
        // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = max(min(happiness, 100), 0)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(_ sender: UIPanGestureRecognizer) {
        switch  sender.state{
        case .ended:
            fallthrough
        case .changed:
            let translation = sender.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPoint.zero, in: faceView)
            }
        default:
            break
        }
        
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
//            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    

    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smiliessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}
