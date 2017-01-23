//
//  JCFPSLabel.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/23.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

class JCFPSLabel: UILabel {

    private var link: CADisplayLink? = nil;
    private var _count: Int = 0;
    private var _lastTime: TimeInterval = 0;
    
    public class func windowsAddFPSLabel() {
        let label = JCFPSLabel.init(frame: CGRect.init(x: 20, y: UIScreen.main.bounds.size.height - 40, width: 55, height: 20));
        UIApplication.shared.keyWindow?.addSubview(label);
    }
    
    override init(frame: CGRect) {
        var rect = frame;
        if (rect.size.equalTo(CGSize.zero)) {
            rect.size = CGSize.init(width: 55, height: 20);
        }
        
        super.init(frame: rect);
        self.layer.cornerRadius = 5;
        self.clipsToBounds = true;
        self.textAlignment = NSTextAlignment.center;
        self.isUserInteractionEnabled = false;
        self.backgroundColor = UIColor.init(white: 0.000, alpha: 0.700);
        self.font = UIFont.systemFont(ofSize: 14);
        
        self.link = CADisplayLink.init(target: self, selector: #selector(tick(link:)));
        self.link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.link?.invalidate();
    }
    
    @objc private func tick(link: CADisplayLink) {
        if (_lastTime == 0) {
            _lastTime = link.timestamp;
        }
        
        _count += 1;
        let delta = link.timestamp - _lastTime;
        
        if (delta < 1) {
            return;
        }
        
        _lastTime = link.timestamp;
        let fps = Double(_count) / delta;
        _count = 0;
        
        let progress: CGFloat = CGFloat(fps) / 60.0;
        let color = UIColor.init(hue: 0.27 * (progress - 0.2), saturation: 1, brightness: 0.9, alpha: 1);
        
        self.textColor = color;
        self.text = "\(Int(round(fps))) FPS"
    }
}
