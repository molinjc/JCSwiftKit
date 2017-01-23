//
//  UINavigationItem+JCLoading.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/22.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

private var _kLoading = "kLoading";

extension UINavigationItem {
    
    func startLoadingAnimating() {
        self.stopLoadingAnimating();
        objc_setAssociatedObject(self, _kLoading, self.titleView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        let loader = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray);
        self.titleView = loader;
        loader.startAnimating();
    }
    
    func stopLoadingAnimating() {
        let componentToRestore = objc_getAssociatedObject(self, _kLoading);
        self.titleView = componentToRestore as! UIView?;
        objc_setAssociatedObject(self, _kLoading, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
