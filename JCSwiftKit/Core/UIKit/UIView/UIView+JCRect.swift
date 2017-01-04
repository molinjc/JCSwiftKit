//
//  JCView.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2016/12/31.
//  Copyright © 2016年 molin. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 获取View所在的控制器，响应链上的第一个Controller
    func viewController() -> UIViewController? {
        var nextResponder = self as UIResponder?;
        
        repeat {
            nextResponder = nextResponder?.next!;
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController;
            }
        }while (nextResponder != nil);
        
        return nil;
    }
    
    /// 清空所有子视图
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview();
        }
    }
    
    func cornerRadius(radius: CGFloat) -> UIView {
        self.clipsToBounds = true;
        self.layer.cornerRadius = radius;
        return self;
    }
    
    func borderWidth(width: CGFloat) -> UIView {
        self.layer.borderWidth = width;
        return self;
    }
    
    func borderColor(color: UIColor) -> UIView {
        self.layer.borderColor = color.cgColor;
        return self;
    }
    
    /// 视图快照(截图)
    func snapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0);
        self.layer.render(in: (UIGraphicsGetCurrentContext())!);
        let snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap!;
    }
    
    ///视图快照(截图) 屏幕会闪下
    func snapshotImageAfterScreenUpdates(afterUpdates: Bool) -> UIImage {
        if !self.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            return self.snapshotImage();
        }
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates);
        let snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap!;
    }
    
    /// 生成快照PDF
    func snapshotPDF() -> NSData {
        var bounds = self.bounds;
        let data = NSMutableData.init();
        let consumer = CGDataConsumer.init(data: data as CFMutableData);
        let context = CGContext.init(consumer: consumer!, mediaBox: &bounds, nil);
        context?.beginPDFPage(nil);
        context?.translateBy(x: 0, y: bounds.size.height);
        context?.scaleBy(x: 1.0, y: -1.0);
        self.layer.render(in: context!);
        context?.endPDFPage();
        context?.closePDF();
        return data;
    }
    
    /// 根据触摸点，获取子视图
    func getSubviewWithTouches(touches: Set<UITouch>) -> AnyObject? {
        let touch = touches.first;
        let point = touch?.location(in: self);
        for _subview in self.subviews {
            if (_subview.frame.contains(point!)) {
                return _subview;
            }
        }
        return nil;
    }
}

// MARK: - Frame
extension UIView {
    
    // frame.origin.x
    var x: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.x = x;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.x;
        }
    }
    
    // frame.origin.y
    var y: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.y = y;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.y;
        }
    }
    
    // frame.size.width
    var width: CGFloat {
        set {
            var rect = self.frame;
            rect.size.width = width;
            self.frame = rect;
        }
        
        get {
            return self.frame.size.width;
        }
    }
    
    // frame.size.height
    var height: CGFloat {
        set {
            var rect = self.frame;
            rect.size.height = height;
            self.frame = rect;
        }
        
        get {
            return self.frame.size.height;
        }
    }
    
    // frame.origin
    var origin: CGPoint {
        set {
            var rect = self.frame;
            rect.origin = origin;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin;
        }
    }
    
    // frame.size
    var size: CGSize {
        set {
            var rect = self.frame;
            rect.size = size;
            self.frame = rect;
        }
        
        get {
            return self.frame.size;
        }
    }
    
    // center.x
    var centerX: CGFloat {
        set {
            var center = self.center;
            center.x = centerX;
            self.center = center;
        }
        
        get {
            return self.center.x;
        }
    }
    
    // center.y
    var centerY: CGFloat {
        set {
            var center = self.center;
            center.y = centerX;
            self.center = center;
        }
        
        get {
            return self.center.y;
        }
    }
    
    // frame.origin.x + frame.size.width
    var right: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.x = right - rect.size.width;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.x + self.frame.size.width;
        }
    }
    
    //
    var bottom: CGFloat {
        set {
            var rect = self.frame;
            rect.origin.y = bottom - rect.size.height;
            self.frame = rect;
        }
        
        get {
            return self.frame.origin.y + self.frame.size.height;
        }
    }
    
    // 左间距
    var leftSpacing: CGFloat {
        set {
            self.x = leftSpacing;
        }
        
        get {
            return self.x;
        }
    }
    
    // 右间距
    var rightSpacing: CGFloat {
        set {
            self.width = (self.superview?.width)! - rightSpacing - self.x;
        }
        
        get {
            return (self.superview?.width)! - self.width - self.x;
        }
    }
    
    // 上间距
    var topSpacing: CGFloat {
        set {
            self.y = topSpacing;
        }
        
        get {
            return self.y;
        }
    }
    
    // 下间距
    var bottomSpacing: CGFloat {
        set {
            self.height = (self.superview?.height)! - bottomSpacing - self.y;
        }
        
        get {
            return (self.superview?.height)! - self.height - self.y;
        }
    }
}
