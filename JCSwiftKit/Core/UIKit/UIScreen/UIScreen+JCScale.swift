//
//  UIScreen+JCScale.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/1.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

var kScale = "kScale"

func JCScreenSetScale(size: CGSize) {
    let screenSize = UIScreen.main.bounds.size;
    var width = screenSize.width;
    if screenSize.width > screenSize.height {
        width = screenSize.height;
    }
    let scale = width / size.width;
    objc_setAssociatedObject(UIScreen.main, &kScale, scale, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
}

func JCScreenGetScale() -> CGFloat {
    return UIScreen.main._scale_;
}

extension UIScreen {
    
    var _scale_: CGFloat {
        get {
            let scaleF = objc_getAssociatedObject(self, &kScale);
            if (scaleF != nil) {
                return scaleF as! CGFloat;
            }
            return self.scale;
        }
    }
    
    /// 获取当前屏幕的bounds
    func currentBounds() -> CGRect {
        return self.boundsForOrientation(orientation: UIApplication.shared.statusBarOrientation)
    }
    
    /// 根据屏幕的旋转方向设置bounds
    func boundsForOrientation(orientation: UIInterfaceOrientation) -> CGRect {
        var bounds = self.bounds;
        if UIInterfaceOrientationIsLandscape(orientation) {
            let buffer = bounds.size.width;
            bounds.size.width = bounds.size.height;
            bounds.size.height = buffer;
        }
        return bounds;
    }
    
    func pixelsPerInch() -> CGFloat {
        var ppi: CGFloat = 0;
        if UIScreen.main.isEqual(self) {
            let model = UIDevice.current.machineModel();
            
            if model.hasPrefix("iPhone") {
                if model.hasPrefix("iPhone1") {
                    ppi = 163;
                }else if model.hasPrefix("iPhone2") {
                    ppi = 163;
                }else if model .hasPrefix("iPhone3") {
                    ppi = 326;
                }else if model .hasPrefix("iPhone4") {
                    ppi = 326;
                }else if model .hasPrefix("iPhone5") {
                    ppi = 326;
                }else if model.hasPrefix("iPhone6") {
                    ppi = 326;
                }else if model.hasPrefix("iPhone7,1") {
                    ppi = 401;
                }else if model.hasPrefix("iPhone7,2") {
                    ppi = 326;
                }
            }else if model.hasPrefix("iPod") {
                if model.hasPrefix("iPod1") {
                    ppi = 163;
                }else if model.hasPrefix("iPod2") {
                    ppi = 163;
                }else if model.hasPrefix("iPod3") {
                    ppi = 163;
                }else if model.hasPrefix("iPod4") {
                    ppi = 326;
                }else if model.hasPrefix("iPod5") {
                    ppi = 326;
                }
        } else if model.hasPrefix("iPad") {
                if model.hasPrefix("iPad1") {
                    ppi = 132;
                }else if model.hasPrefix("iPad2,1") {
                    ppi = 132;
                }else if model.hasPrefix("iPad2,2") {
                    ppi = 132;
                }else if model.hasPrefix("iPad2,3") {
                    ppi = 132;
                }else if model.hasPrefix("iPad2,4") {
                    ppi = 132;
                }else if model.hasPrefix("iPad2,5") {
                    ppi = 163;
                }else if model.hasPrefix("iPad2,6") {
                    ppi = 163;
                }else if model.hasPrefix("iPad2,7") {
                    ppi = 163;
                }else if model.hasPrefix("iPad3") {
                    ppi = 264;
                }else if model.hasPrefix("iPad4,1") {
                    ppi = 264;
                }else if model.hasPrefix("iPad4,2") {
                    ppi = 264;
                }else if model.hasPrefix("iPad4,3") {
                    ppi = 264;
                }else if model.hasPrefix("iPad4,4") {
                    ppi = 324;
                }else if model.hasPrefix("iPad4,5") {
                    ppi = 324;
                }else if model.hasPrefix("iPad4,6") {
                    ppi = 324;
                }else if model.hasPrefix("iPad4,7") {
                    ppi = 324;
                }else if model.hasPrefix("iPad4,8") {
                    ppi = 324;
                }else if model.hasPrefix("iPad4,9") {
                    ppi = 324;
                }else if model.hasPrefix("iPad5,3") {
                    ppi = 264;
                }else if model.hasPrefix("iPad5,4") {
                    ppi = 324;
                }
           }
        }
        
        if (ppi == 0) {
            ppi = 326;
        }
        return ppi;
    }
}
