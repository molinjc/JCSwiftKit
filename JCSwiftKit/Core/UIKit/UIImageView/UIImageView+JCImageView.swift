//
//  UIImageView+JCImageView.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/22.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 设置图片名
    func imageNamed(_ name: String) {
        self.image = UIImage.init(named: name);
    }
    
    /// 倒影
    func imageReflect() {
        var _frame = self.frame;
        _frame.origin.y += (_frame.size.height + 1);
        
        let reflectionImageView = UIImageView.init(frame: _frame);
        self.clipsToBounds = true;
        reflectionImageView.contentMode = self.contentMode;
        reflectionImageView.image = self.image;
        reflectionImageView.transform = CGAffineTransform(scaleX: 1.0, y: -1.0);
        
        let reflectionLayer = reflectionImageView.layer;
        
        let gradientLayer = CAGradientLayer.init();
        gradientLayer.bounds = reflectionLayer.bounds;
        gradientLayer.position = CGPoint.init(x: reflectionLayer.bounds.size.width / 2, y: reflectionLayer.bounds.size.height * 0.5);
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3).cgColor];
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0.5);
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1.0);
        reflectionLayer.mask = gradientLayer;
        
        self.superview?.addSubview(reflectionImageView);
    }
    
    /// 画水印
    ///
    /// - Parameters:
    ///   - watermark: 水印图
    ///   - inRect: 水印图的位置
    func watermark(_ watermark: UIImage, inRect: CGRect) {
        if (self.image == nil ) {
            self.image = watermark;
        }
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0);
        self.image?.draw(in: self.bounds);
        watermark.draw(in: inRect);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.image = newImage;
    }
}
