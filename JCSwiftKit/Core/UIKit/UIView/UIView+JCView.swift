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

var kLayoutConstraints = "kLayoutConstraints";
var kleft = "Left";
var kright = "Right";
var ktop = "Top";
var kbottom =  "Bottom";
var kcenterX =  "CenterX";
var kcenterY =  "CenterY";
var kwidth =  "Width";
var kheight =  "Height";

var ksameLayerLeft =  "sameLayerLeft";
var ksameLayerRight =  "sameLayerRight";
var ksameLayerTop =  "sameLayerTop";
var ksameLayerBottom =  "sameLayerBottom";
var ksameLayerCenterX =  "sameLayerCenterX";
var ksameLayerCenterY =  "sameLayerCenterY";
var ksameLayerWidth =  "sameLayerWidth";
var ksameLayerHeight =  "sameLayerHeight";

var ksameLayerLeft_C =  "sameLayerLeft_C";
var ksameLayerRight_C =  "sameLayerRight_C";
var ksameLayerTop_C =  "sameLayerTop_C";
var ksameLayerBottom_C =  "sameLayerBottom_C";

// MARK: - Layout
extension UIView {
    
    private var layoutConstraints:NSMutableDictionary {
        get {
            var ls = objc_getAssociatedObject(self, &kLayoutConstraints);
            if ls == nil {
                ls = NSMutableDictionary.init();
                objc_setAssociatedObject(self, &kLayoutConstraints, ls, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return ls as! NSMutableDictionary;
        }
    }
    
    func layoutScale() -> UIView {
        self.layoutConstraints.enumerateKeysAndObjects({ (key, constraint, stop) in
            (constraint as! NSLayoutConstraint).constant *= UIScreen.main._scale_;
        });
        self.superview?.layoutIfNeeded();
        return self;
    }
    
    func layoutRemoveAll() -> UIView {
        self.layoutConstraints.enumerateKeysAndObjects({ (key, constraint, stop) in
            self.superview?.removeConstraint((constraint as! NSLayoutConstraint));
        });
        self.superview?.layoutIfNeeded();
        return self;
    }
    
    /* *** 参照父视图属性 *** */
    
    /// left，相当于x，参照俯视图的NSLayoutAttributeLeft
    func layoutLeft(left: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.left, constant: left, key: kleft);
        return self;
    }
    
    /// right，与俯视图右边的间距，参照俯视图的NSLayoutAttributeRight
    func layoutRight(right: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.right, constant: -right, key: kright);
        return self;
    }
    
    /// top，相当于y，参照俯视图的NSLayoutAttributeTop
    func layoutTop(top: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.top, constant: top, key: ktop);
        return self;
    }
    
    /// bottom，与俯视图底边的间距，参照俯视图的NSLayoutAttributeBottom
    func layoutBottom(bottom: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.bottom, constant: bottom, key: kbottom);
        return self;
    }
    
    /// Width， 无参照物，设置自身的宽，NSLayoutAttributeWidth
    func layoutWidth(width: CGFloat) -> UIView {
        self.layoutSelfConstraint(attribute: NSLayoutAttribute.width, constant: width, key: kwidth);
        return self;
    }
    
    /// height，无参照物，设置自身的高，NSLayoutAttributeHeight
    func layoutHeight(height: CGFloat) -> UIView {
        self.layoutSelfConstraint(attribute: NSLayoutAttribute.height, constant: height, key: kheight);
        return self;
    }
    
    /// CenterX，参照父视图的CenterX设置自身的CenterX，NSLayoutAttributeCenterX
    func layoutCenterX(centerX: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.centerX, constant: centerX, key: kcenterX);
        return self;
    }
    
    /// CenterY，参照父视图的CenterY设置自身的CenterY，NSLayoutAttributeCenterY
    func layoutCenterY(centerY: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.centerY, constant: centerY, key: kcenterY);
        return self;
    }
    
    /* *** 参照父视图的属性，是父视图属性的multiplier倍 *** */
    
    /// left，相当于x，参照俯视图的NSLayoutAttributeLeft的multiplier倍
    func layoutLeft(left: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.left, constant: left, multiplier: multiplier, key: kleft);
        return self;
    }
    
    /// right，与俯视图右边的间距，参照俯视图的NSLayoutAttributeRight的multiplier倍
    func layoutRight(right: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.right, constant: right, multiplier: multiplier, key: kright);
        return self;
    }
    
    /// top，相当于y，参照俯视图的NSLayoutAttributeTop的multiplier倍
    func layoutTop(top: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.top, constant: top, multiplier: multiplier, key: ktop);
        return self;
    }
    
    /// bottom，与俯视图底边的间距，参照俯视图的NSLayoutAttributeBottom的multiplier倍
    func layoutBottom(bottom: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.bottom, constant: -bottom, multiplier: multiplier, key: kbottom);
        return self;
    }
    
    /// Width， 参照物，设置自身的宽，NSLayoutAttributeWidth的multiplier倍
    func layoutWidth(width: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.width, constant: width, multiplier: multiplier, key: kwidth);
        return self;
    }
    
    /// height，参照物，设置自身的高，NSLayoutAttributeHeight的multiplier倍
    func layoutHeight(height: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.height, constant: height, multiplier: multiplier, key: kheight);
        return self;
    }
    
    /// CenterX，参照父视图的CenterX设置自身的CenterX，NSLayoutAttributeCenterX的multiplier倍
    func layoutCenterX(centerX: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.centerX, constant: centerX, multiplier: multiplier, key: kcenterX);
        return self;
    }
    
    /// CenterY，参照父视图的CenterY设置自身的CenterY，NSLayoutAttributeCenterY的multiplier倍
    func layoutCenterY(centerY: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSuperviewConstraint(attribute: NSLayoutAttribute.centerY, constant: centerY, multiplier: multiplier, key: kcenterY);
        return self;
    }
    
    /* *** 参照同层级视图相同属性 *** */
    
    /// 参照同层级view的left
    func layoutSameLayer(sameLayerView: UIView, left: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.left, constant: left, key: ksameLayerLeft);
        return self;
    }
    
    /// 参照同层级view的right
    func layoutSameLayer(sameLayerView: UIView, right: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.right, constant: right, key: ksameLayerRight);
        return self;
    }
    
    /// 参照同层级view的top
    func layoutSameLayer(sameLayerView: UIView, top: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.top, constant: top, key: ksameLayerTop);
        return self;
    }
    
    /// 参照同层级view的bottom
    func layoutSameLayer(sameLayerView: UIView, bottom: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.bottom, constant: bottom, key: ksameLayerBottom);
        return self;
    }
    
    ///  参照同层级view的width
    func layoutSameLayer(sameLayerView: UIView, width: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.width, constant: width, key: ksameLayerWidth);
        return self;
    }
    
    /// 参照同层级view的height
    func layoutSameLayer(sameLayerView: UIView, height: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.height, constant: height, key: ksameLayerHeight);
        return self;
    }
    
    /// 参照同层级view的centerX
    func layoutSameLayer(sameLayerView: UIView, centerX: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.centerX, constant: centerX, key: ksameLayerCenterX);
        return self;
    }
    
    /// 参照同层级view的centerY
    func layoutSameLayer(sameLayerView: UIView, centerY: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.centerY, constant: centerY, key: ksameLayerCenterY);
        return self;
    }
    
    /* *** 参照同层级视图相同属性，是同层级视图的multiplier倍 ****/
    
    /// 参照同层级view的left
    func layoutSameLayer(sameLayerView: UIView, left: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.left, constant: left, multiplier: multiplier, key: ksameLayerLeft);
        return self;
    }
    
    /// 参照同层级view的right
    func layoutSameLayer(sameLayerView: UIView, right: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.right, constant: right, multiplier: multiplier, key: ksameLayerRight);
        return self;
    }
    
    /// 参照同层级view的top
    func layoutSameLayer(sameLayerView: UIView, top: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.top, constant: top, multiplier: multiplier, key: ksameLayerTop);
        return self;
    }
    
    /// 参照同层级view的bottom
    func layoutSameLayer(sameLayerView: UIView, bottom: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.bottom, constant: bottom, multiplier: multiplier, key: ksameLayerBottom);
        return self;
    }
    
    /// 参照同层级view的width
    func layoutSameLayer(sameLayerView: UIView, width: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.width, constant: width, multiplier: multiplier, key: ksameLayerWidth);
        return self;
    }
    
    /// 参照同层级view的height
    func layoutSameLayer(sameLayerView: UIView, height: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.height, constant: height, multiplier: multiplier, key: ksameLayerHeight);
        return self;
    }
    
    /// 参照同层级view的centerX
    func layoutSameLayer(sameLayerView: UIView, centerX: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.centerX, constant: centerX, multiplier: multiplier, key: ksameLayerCenterX);
        return self;
    }
    
    /// 参照同层级view的centerY
    func layoutSameLayer(sameLayerView: UIView, centerY: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute: NSLayoutAttribute.centerY, constant: centerY, multiplier: multiplier, key: ksameLayerCenterY);
        return self;
    }
    
    /* *** 参照同层级视图相反属性 *** */
    
    /// 参照同层级view的left，在同层级view的左边（left），也就是同层级view在self的右边（right）
    func layoutAtSameLayerLeft(sameLayerView: UIView, constant: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.right, attribute2: NSLayoutAttribute.left, constant: constant, key: ksameLayerLeft_C);
        return self;
    }
    
    /// 参照同层级view的right，在同层级view的右边（right），也就是同层级view在self的左边（left）
    func layoutAtSameLayerRight(sameLayerView: UIView, constant: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.left, attribute2: NSLayoutAttribute.right, constant: constant, key: ksameLayerRight_C);
        return self;
    }
    
    /// 参照同层级view的top，在同层级view的顶边（top），也就是同层级view在self的底边（bottom）
    func layoutAtSameLayerTop(sameLayerView: UIView, constant: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.bottom, attribute2: NSLayoutAttribute.top, constant: -constant, key: ksameLayerTop_C);
        return self;
    }
    
    /// 参照同层级view的bottom，在同层级view的底边（bottom），也就是同层级view在self的顶边（top）
    func layoutAtSameLayerBottom(sameLayerView: UIView, constant: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.top, attribute2: NSLayoutAttribute.bottom, constant: constant, key: ksameLayerBottom_C);
        return self;
    }
    
    /// 参照同层级view的left，在同层级view的左边（left），也就是同层级view在self的右边（right）
    func layoutAtSameLayerLeft(sameLayerView: UIView, constant: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.right, attribute2: NSLayoutAttribute.left, constant: constant, multiplier: multiplier, key: ksameLayerLeft_C);
        return self;
    }
    
    /* *** 参照同层级视图相反属性，是同层级视图相反属性的multiplier倍 *** */
    
    /// 参照同层级view的right，在同层级view的右边（right），也就是同层级view在self的左边（left）
    func layoutAtSameLayerRight(sameLayerView: UIView, constant: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.left, attribute2: NSLayoutAttribute.right, constant: constant, multiplier: multiplier, key: ksameLayerRight_C);
        return self;
    }
    
    /// 参照同层级view的top，在同层级view的顶边（top），也就是同层级view在self的底边（bottom）
    func layoutAtSameLayerTop(sameLayerView: UIView, constant: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.bottom, attribute2: NSLayoutAttribute.top, constant: -constant, multiplier: multiplier, key: ksameLayerTop_C);
        return self;
    }
    
    /// 参照同层级view的bottom，在同层级view的底边（bottom），也就是同层级view在self的顶边（top）
    func layoutAtSameLayerBottom(sameLayerView: UIView, constant: CGFloat, multiplier: CGFloat) -> UIView {
        self.layoutSameLayerViewConstraint(sameLayerView: sameLayerView, attribute1: NSLayoutAttribute.top, attribute2: NSLayoutAttribute.bottom, constant: constant, multiplier: multiplier, key: ksameLayerBottom_C)
        return self;
    }
    
    /* *** 简化方法 ****/
    
    /// 简化 1
    private func layoutSuperviewConstraint(attribute: NSLayoutAttribute, constant: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(attribute: attribute, constant: constant, multiplier: 1.0);
        }else {
            constraint?.constant = constant;
        }
    }
    
    /// 简化 2
    private func layoutSuperviewConstraint(attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat,  key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(attribute: attribute, constant: constant, multiplier: multiplier);
        }else {
            self.superview?.removeConstraint(constraint!);
            self.addToSuperviewConstraint(attribute: attribute, constant: constant, multiplier: multiplier);
        }
    }
    
    /// 简化 3
    private func layoutSelfConstraint(attribute: NSLayoutAttribute, constant: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSelfConstraint(attribute: attribute, constant: constant, multiplier: 1.0);
        }else {
            constraint?.constant = constant;
        }
    }
    
    /// 简化 4
    private func layoutSameLayerViewConstraint(sameLayerView: UIView, attribute: NSLayoutAttribute, constant: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute: attribute, constant: constant, multiplier: 1.0);
        }else {
            constraint?.constant = constant;
        }
    }
    
    /// 简化 5
    private func layoutSameLayerViewConstraint(sameLayerView: UIView, attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute: attribute, constant: constant, multiplier: multiplier);
        }else {
            self.superview?.removeConstraint(constraint!);
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute: attribute, constant: constant, multiplier: multiplier);
        }
    }
    
    /// 简化 6
    private func layoutSameLayerViewConstraint(sameLayerView: UIView, attribute1: NSLayoutAttribute, attribute2: NSLayoutAttribute, constant: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute1: attribute1, attribute2: attribute2, constant: constant, multiplier: 1.0);
        }else {
            constraint?.constant = constant;
        }
    }
    
    /// 简化 7
    private func layoutSameLayerViewConstraint(sameLayerView: UIView, attribute1: NSLayoutAttribute, attribute2: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat, key: String) {
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        let constraint = self.layoutConstraints[key] as! NSLayoutConstraint?;
        if (constraint == nil) {
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute1: attribute1, attribute2: attribute2, constant: constant, multiplier: multiplier);
        }else {
            self.superview?.removeConstraint(constraint!);
            self.addToSuperviewConstraint(sameLayerView: sameLayerView, attribute1: attribute1, attribute2: attribute2, constant: constant, multiplier: multiplier);
        }
    }
    
    /* *** NSLayoutConstraint *** */
    
    /// 参照物为父视图，该约束被添加到父视图
    private func addToSuperviewConstraint(attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat) {
        let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: attribute, relatedBy: NSLayoutRelation.equal, toItem: self.superview, attribute: attribute, multiplier: multiplier, constant: constant);
        if (self.superview == nil) {
            assert(self.superview == nil, "没有父视图");
            return;
        }
        self.layoutConstraints.setValue(layoutConstraint, forKey: self.keyWithLayoutAttribute(attribute: attribute));
        self.superview?.addConstraint(layoutConstraint);
    }
    
    /// 参照物为同层级view, 该约束被添加到父视图
    private func addToSuperviewConstraint(sameLayerView: UIView, attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat) {
        let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: attribute, relatedBy: NSLayoutRelation.equal, toItem: sameLayerView, attribute: attribute, multiplier: multiplier, constant: constant);
        if (self.superview == nil) {
            assert(self.superview == nil, "没有父视图");
            return;
        }
        self.layoutConstraints.setValue(layoutConstraint, forKey: String.init(format: "sameLayer%@", self.keyWithLayoutAttribute(attribute: attribute)));
        self.superview?.addConstraint(layoutConstraint);
    }
    
    /// 参照物为同层级view
    private func addToSuperviewConstraint(sameLayerView: UIView, attribute1: NSLayoutAttribute, attribute2: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat) {
        let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: attribute1, relatedBy: NSLayoutRelation.equal, toItem: sameLayerView, attribute: attribute2, multiplier: multiplier, constant: constant);
        if (self.superview == nil) {
            assert(self.superview == nil, "没有父视图");
            return;
        }
        self.layoutConstraints.setValue(layoutConstraint, forKey: String.init(format: "sameLayer%@_C", self.keyWithLayoutAttribute(attribute: attribute2)));
        self.superview?.addConstraint(layoutConstraint);
    }
    
    /// 参照物无，该约束被添加到自身
    private func addToSelfConstraint(attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat) {
        let layoutConstraint = NSLayoutConstraint.init(item: self, attribute: attribute, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: attribute, multiplier: multiplier, constant: constant);
        self.layoutConstraints.setValue(layoutConstraint, forKey: self.keyWithLayoutAttribute(attribute: attribute));
        self.addConstraint(layoutConstraint);
    }
    
    private func keyWithLayoutAttribute(attribute: NSLayoutAttribute) -> String {
        switch attribute {
        case NSLayoutAttribute.left:
            return kleft;
        case NSLayoutAttribute.right:
            return kright;
        case NSLayoutAttribute.top:
            return ktop;
        case NSLayoutAttribute.bottom:
            return kbottom;
        case NSLayoutAttribute.width:
            return kwidth;
        case NSLayoutAttribute.height:
            return kheight;
        case NSLayoutAttribute.centerX:
            return kcenterX;
        case NSLayoutAttribute.centerY:
            return kcenterY;
        default:
            return ""
        }
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
