//
//  ViewController.swift
//  CAReplicatorLayerDemo1
//
//  Created by I_MT on 16/9/22.
//  Copyright © 2016年 I_MT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    //             参考：   http:www.jianshu.com/p/f13b1cbdabc7
//        animation2()
        animation3();
    }
    //旋转指示器
    /**
     不太明白的是，为什么在变大变小的过程中还自带旋转？不单单是复制这么简单？
     */
    func animation2(){
        let repLayer = CAReplicatorLayer();
        repLayer.bounds=CGRectMake(0, 0, 200, 200)
        repLayer.position=view.center;
        repLayer.backgroundColor=UIColor(white: 0, alpha: 0.75).CGColor
        view.layer.addSublayer(repLayer);
        
        let dot = CALayer();
        dot.bounds=CGRectMake(0, 0, 14, 14);
        dot.position=CGPointMake(100, 40)
        dot.backgroundColor=UIColor(white: 0.8, alpha: 1.0).CGColor
        dot.borderColor=UIColor(white: 1, alpha: 1).CGColor
        dot.borderWidth=1.0
        dot.cornerRadius=2.0;
        dot.transform =  CATransform3DMakeScale(0.1, 0.1, 1)
        repLayer.addSublayer(dot)
        
        let dotCount:Int=15;
        let angle = CGFloat(2*M_PI)/CGFloat(dotCount)
//        let angle = CGFloat(40*M_PI/180.0);
        repLayer.instanceCount = dotCount;
        repLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
//        repLayer.instanceTransform=CATransform3DMakeTranslation(10, 0, 0);
        let scaleAni = CABasicAnimation()
        let duration = 1.5
        scaleAni.duration=duration
        scaleAni.keyPath="transform.scale";
        scaleAni.fromValue = 1.0;
        scaleAni.toValue = 0.1;
        scaleAni.repeatCount=Float.infinity
//        scaleAni.autoreverses=true
        dot.addAnimation(scaleAni, forKey: "scaleShringk")
        repLayer.instanceDelay = duration/Double(dotCount)

        
    }
    /**
     1.不太理解如何画出贝塞尔曲线的
     2.不明白为何小球移动不匀速？和贝塞尔曲线有关？
     */
    func animation3() {
        let r = CAReplicatorLayer()
        r.bounds = view.bounds
        r.backgroundColor = UIColor(white:0.0, alpha:0.75).CGColor
        r.position = view.center
        
        view.layer.addSublayer(r)
        let dot = CALayer()
        dot.bounds = CGRect(x:0.0, y:0.0, width:10.0, height:10.0)
        dot.backgroundColor = UIColor(white:0.8, alpha:1.0).CGColor
        dot.borderColor = UIColor(white:1.0, alpha:1.0).CGColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 5.0
        dot.shouldRasterize = true
        dot.rasterizationScale = UIScreen.mainScreen().scale
        
        r.addSublayer(dot)
        //动画
        let move = CAKeyframeAnimation(keyPath:"position")
        move.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        move.path = rw()
        move.repeatCount = Float.infinity
        move.duration = 4.0
        dot.addAnimation(move, forKey: nil)
        r.instanceCount = 39
        r.instanceDelay = 0.1
        //关于颜色
        r.instanceColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:1.0).CGColor
        r.instanceGreenOffset = -0.03
    }
    func rw() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(31.5, 71.5))
        bezierPath.addLineToPoint(CGPointMake(31.5, 23.5))
        bezierPath.addCurveToPoint(CGPointMake(58.5, 38.5), controlPoint1: CGPointMake(31.5, 23.5), controlPoint2: CGPointMake(62.46, 18.69))
        bezierPath.addCurveToPoint(CGPointMake(53.5, 45.5), controlPoint1: CGPointMake(57.5, 43.5), controlPoint2: CGPointMake(53.5, 45.5))
        bezierPath.addLineToPoint(CGPointMake(43.5, 48.5))
        bezierPath.addLineToPoint(CGPointMake(53.5, 66.5))
        bezierPath.addLineToPoint(CGPointMake(62.5, 51.5))
        bezierPath.addLineToPoint(CGPointMake(70.5, 66.5))
        bezierPath.addLineToPoint(CGPointMake(86.5, 23.5))
        bezierPath.addLineToPoint(CGPointMake(86.5, 78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5, 78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5, 71.5))
        bezierPath.closePath()
        
        var t = CGAffineTransformMakeScale(3.0, 3.0)
        return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &t)!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

