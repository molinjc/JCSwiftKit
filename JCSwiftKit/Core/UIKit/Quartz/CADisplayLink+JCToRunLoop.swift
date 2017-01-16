//
//  CADisplayLink+JCToRunLoop.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/13.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension CADisplayLink {
    
    static func displayLinkToRunLoop(target: Any, selector: Selector) -> CADisplayLink {
        let displayLink = CADisplayLink.init(target: target, selector: selector);
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes);
        return displayLink;
    }
    
    func stopDisplayLink() {
        self.invalidate();
    }
}
