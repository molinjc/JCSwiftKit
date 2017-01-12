//
//  JCProgressButton.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/12.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

class JCProgressButton: UIView {

    private let _button: UIButton = UIButton.init(type: UIButtonType.roundedRect);
    private let _progressLayer: CAShapeLayer = CAShapeLayer.init();
    private var _timer: Timer? = Timer.init();
    private var _progress: CGFloat = 0.0;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initBase();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initBase() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.masksToBounds = true;
        
        _button.setTitle("跳过", for: UIControlState.normal);
        _button.setTitleColor(UIColor.white, for: UIControlState.normal);
        _button.addTarget(self, action: #selector(buttonEvent(sender:)), for: UIControlEvents.touchUpInside);
        _button.frame = self.bounds;
        self.addSubview(_button);
        
        _progressLayer.fillColor = UIColor.clear.cgColor;
        _progressLayer.strokeColor = UIColor.red.cgColor;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        _progressLayer.lineCap = kCAFillRuleNonZero;
        _progressLayer.lineJoin = kCALineJoinRound;
        _progressLayer.lineWidth = 3;
        _progressLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: (self.frame.size.width - 5) / 2, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(3*M_PI/2), clockwise: true).cgPath;
        self.layer.addSublayer(_progressLayer);
    }
    
    func state() {
        _progress = 0;
        _timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(progress(sender:)), userInfo: nil, repeats: true);
    }
    
   @objc private func progress(sender: Timer) {
        _progress += 0.01;
        _progressLayer.strokeEnd = _progress;
        if _progress >= 1 {
            _timer?.invalidate();
            _timer = nil;
        }
    }
    
   @objc private func buttonEvent(sender: UIButton) {
        NSLog("000000")
    }
}

