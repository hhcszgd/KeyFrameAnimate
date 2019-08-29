//
//  ViewController.swift
//  KeyFrameAnimate
//
//  Created by WY on 2019/8/28.
//  Copyright © 2019 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public var delay: TimeInterval = 0.16
    private var timer: Timer?
    public static var sparkColorSet: [UIColor] = {
        return [
            UIColor(red:0.89, green:0.58, blue:0.70, alpha:1.00),
            UIColor(red:0.96, green:0.87, blue:0.62, alpha:1.00),
            UIColor(red:0.67, green:0.82, blue:0.94, alpha:1.00),
            UIColor(red:0.54, green:0.56, blue:0.94, alpha:1.00),
        ]
    }()
//    lazy var  origins : [CGPoint] = [
//        CGPoint(x: theView.frame.minX, y: theView.frame.minY),
//        CGPoint(x: theView.frame.maxX, y: theView.frame.minY),
//        CGPoint(x: theView.frame.minX, y: theView.frame.maxY),
//        CGPoint(x: theView.frame.maxX, y: theView.frame.maxY),
//    ]
    var theView = UIView(frame: CGRect(x: 50, y: 200, width: 44, height: 44))
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("xxxxxx")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(theView)
        theView.backgroundColor = .blue
//        timerDidFire()
//        self.scheduleTimer()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
//            self.timerDidFire()
        AddFireAssistent.share.startByView(theView)
//            self.scheduleTimer()
//        }
        // Do any additional setup after loading the view.
    }
    func perform()  {

    }


    
    public func cancel() {
        self.timer?.invalidate()
        self.timer = nil
    }

    private func scheduleTimer() {
        self.cancel()
        self.timer = Timer(timeInterval: self.delay, target: self , selector: #selector(timerDidFire), userInfo: nil , repeats: true )
        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
//        self.timer = Timer.scheduledTimer(timeInterval: self.delay,
//                                          target: self,
//                                          selector: #selector(timerDidFire),
//                                          userInfo: nil, repeats: true)
    }
    @objc private func timerDidFire() {
        let timeInterval : CFTimeInterval = 0.6
        //https://www.desmos.com/calculator/epunzldltu
        let paths : [(curve1Point: CGPoint , curve2Point : CGPoint , endPoint : CGPoint)] = [
            (curve1Point: CGPoint(x: 80, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 178, y: 400)),
            (curve1Point: CGPoint(x: 91, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 278, y: 400)),
            (curve1Point: CGPoint(x: 99, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 200, y: 700)),
            (curve1Point: CGPoint(x: 110, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 150, y: 400)),
            (curve1Point: CGPoint(x: 75, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 133, y: 400)),
            (curve1Point: CGPoint(x: 87, y: 33) , curve2Point : CGPoint(x: 146, y: 42) , endPoint : CGPoint(x: 300, y: 400)),
        ]
//           guard let data = self.queue.first else {
//               self.cancel()
//               return
//           }
//
//           guard let presenterView = data.presenterView else {
//               self.cancel()
//               return
//           }

        let path = UIBezierPath()
        let fireView  = VVVV(frame: CGRect(x: 50, y: 100, width: 44, height: 44))
        fireView.layer.cornerRadius = 22
        self.view.addSubview(fireView)
        fireView.isHidden = false
//        let fireView = self.theView
        let beFireViewPoint = fireView.frame.origin
        let startPoint = CGPoint(x: beFireViewPoint.x , y: beFireViewPoint.y)
//        let curve1Point = CGPoint(x:87, y:   33)
//        let curve2Point = CGPoint(x:146, y:42)
//        let endPoint = CGPoint(x:178, y: 400)
        let curve1Point = paths[Int(arc4random_uniform(5))].curve1Point
        let curve2Point = paths[Int(arc4random_uniform(5))].curve2Point
        let endPoint = paths[Int(arc4random_uniform(5))].endPoint
        
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: curve1Point, controlPoint2: curve2Point)
        
        
      
        
        
        
        
//        let fireView = UIView(frame: CGRect(x: 110, y: 220, width: 14, height: 14))
        let a = Int(arc4random_uniform(3))
        fireView.backgroundColor = ViewController.sparkColorSet[a]
//        self.view.addSubview(fireView)
        CATransaction.begin()
        
        
        // Position
        let positionAnim = CAKeyframeAnimation(keyPath: "position")
        positionAnim.path = path.cgPath
        positionAnim.calculationMode = CAAnimationCalculationMode.linear
        positionAnim.rotationMode = CAAnimationRotationMode.rotateAuto
        positionAnim.duration = timeInterval
        
        
        // Scale
//        let randomMaxScale = 1.0 + CGFloat(arc4random_uniform(7)) / 10.0
//        let randomMinScale = 0.5 + CGFloat(arc4random_uniform(3)) / 10.0
        let randomMaxScale : CGFloat = 1.0
        let randomMinScale : CGFloat = 0.2
        
        let fromTransform = CATransform3DIdentity
        let byTransform = CATransform3DScale(fromTransform, randomMaxScale, randomMaxScale, randomMaxScale)
        let toTransform = CATransform3DScale(CATransform3DIdentity, randomMinScale, randomMinScale, randomMinScale)
        let transformAnim = CAKeyframeAnimation(keyPath: "transform")

        transformAnim.values = [
            NSValue(caTransform3D: fromTransform),
            NSValue(caTransform3D: byTransform),
            NSValue(caTransform3D: byTransform),
            NSValue(caTransform3D: toTransform)
        ]
        transformAnim.keyTimes = [0.0, 0.2, 0.5, 0.95]
        transformAnim.duration = timeInterval
        transformAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fireView.layer.transform = toTransform
        
        
        // Opacity
        let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnim.values = [1.0, 0.0]
        opacityAnim.keyTimes = [0.9, 1]
        opacityAnim.duration = timeInterval
        fireView.layer.opacity = 0.0

        // Group
          let groupAnimation = CAAnimationGroup()
          groupAnimation.animations = [positionAnim, transformAnim, opacityAnim]
        groupAnimation.duration = timeInterval

          CATransaction.setCompletionBlock({
            fireView.layer.removeAllAnimations()
              fireView.removeFromSuperview()
          })

        fireView.layer.add(groupAnimation, forKey: nil )

        CATransaction.commit()
        
        
        
        
//           for spark in data.sparks {
//               presenterView.addSubview(spark.sparkView)
//               data.animator.animate(spark: spark, duration: data.animationDuration)
//           }
//
//           self.queue.remove(at: 0)
//
//           if self.queue.isEmpty {
//               self.cancel()
//           } else {
//               self.scheduleTimer()
//           }
//        self.scheduleTimer()
       }
}

