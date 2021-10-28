//
//  CircularProgressBarView.swift
//  ESRC-iOS
//
//  Created by Mac_Joseph on 2021/06/25.
//

import UIKit
class CircularProgressBarView: UIView {
    // First create two layer properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 20, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 4.0
        circleLayer.strokeColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.0).cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 4.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor(red: 0.92, green: 0.0, blue: 0.55, alpha: 1.0).cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    func progressAnimation(ratio: Double, oneStep: Double) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circularProgressAnimation.duration = duration
//        circularProgressAnimation.byValue = 0.01
        circularProgressAnimation.fromValue = ratio * 0.01 - oneStep
        circularProgressAnimation.toValue = ratio * 0.01 
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
