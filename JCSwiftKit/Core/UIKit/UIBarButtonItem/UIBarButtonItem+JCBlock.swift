//
//  UIBarButtonItem+JCBlock.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/3.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit
import Foundation

class _JCUIBarButtonItemClosureTarget: NSObject {
    
    var closureEvent:((_ sender: UIBarButtonItem) -> Void);
    
    init(closure: @escaping (UIBarButtonItem) -> Void) {
        self.closureEvent = closure;
    }
    
    func barButtonItem_invoke(sender: UIBarButtonItem) {
        self.closureEvent(sender);
    }
}

var kTarget = "Target";

extension UIBarButtonItem {
    
    func setActionClosure(closure: @escaping (UIBarButtonItem) -> Void) {
        let closureTarget = _JCUIBarButtonItemClosureTarget.init(closure: closure);
        objc_setAssociatedObject(self, &kTarget, closureTarget, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.target = closureTarget;
        self.action = #selector(_JCUIBarButtonItemClosureTarget.barButtonItem_invoke(sender:));
    }
}
