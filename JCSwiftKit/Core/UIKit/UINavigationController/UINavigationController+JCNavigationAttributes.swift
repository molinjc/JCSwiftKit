//
//  UINavigationController+JCNavigationAttributes.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/6.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// 设置navigationBar背景颜色
    func navigationBarTintColor(color: UIColor) {
        self.navigationBar.barTintColor = color;
    }
    
    /// 设置导航栏的字体
    func navigationBarTitle(font: UIFont) {
        var attributesDic = self.navigationBar.titleTextAttributes;
        if (attributesDic == nil) {
            attributesDic = Dictionary.init();
        }
        attributesDic?[NSFontAttributeName] = font;
        self.navigationBar.titleTextAttributes = attributesDic;
    }
    
    /// 设置导航栏的字体颜色
    func navigationBarTitle(color: UIColor) {
        var attributesDic = self.navigationBar.titleTextAttributes;
        if (attributesDic == nil) {
            attributesDic = Dictionary.init();
        }
        attributesDic?[NSForegroundColorAttributeName] = color;
        self.navigationBar.titleTextAttributes = attributesDic;
    }
    
    /// 设置导航栏的返回键颜色
    func navigationTintColor(color: UIColor) {
        self.navigationBar.tintColor = color;
    }
    
    /// 设置navigationBar透明
    func navigationBarTransparentBackground() {
        self.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default);
    }
    
    /// 隐藏navigationBar下的横线
    func navigationBarHiddenLine() {
        self.navigationBar.shadowImage = UIImage.init();
    }
    
    /// navigationBar的透明渐变
    func navigationBarTransparentGradient(alpha: CGFloat) {
        self.navigationBar.subviews.first?.alpha = alpha;
    }
    
    /// 动画跳转到下一个viewController
    func pushViewController(viewController: UIViewController, transition: UIViewAnimationTransition) {
        UIView.beginAnimations(nil, context: nil);
        self.pushViewController(viewController, animated: false);
        UIView.setAnimationDuration(0.5);
        UIView.setAnimationBeginsFromCurrentState(true);
        UIView.setAnimationTransition(transition, for: self.view, cache: true);
        UIView.commitAnimations();
    }
    
    /// 动画跳转到上一个viewController
    func popViewController(transition: UIViewAnimationTransition) -> UIViewController? {
        UIView.beginAnimations(nil, context: nil);
        let viewController = self.popViewController(animated: false);
        UIView.setAnimationDuration(0.5);
        UIView.setAnimationBeginsFromCurrentState(true);
        UIView.setAnimationTransition(transition, for: self.view, cache: true);
        UIView.commitAnimations();
        return viewController;
    }
    
    /// 回到上层
    func popToViewController(level: Int, animated: Bool) -> Array<UIViewController>? {
        let count = self.viewControllers.count;
        if count > level {
            let index = count - level - 1;
            let viewController = self.viewControllers[index];
            return self.popToViewController(viewController, animated: animated);
        }
        return self.popToRootViewController(animated: animated);
    }
    
    /// 回到指定类名的上层
    func popToViewController(className: String, animated: Bool) -> Array<UIViewController>? {
        for viewController in self.viewControllers {
            if viewController .isKind(of: JCClassFromString(className)!) {
                return self.popToViewController(viewController, animated: animated);
            }
        }
        return self.viewControllers;
    }
}
