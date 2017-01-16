//
//  JCGraphicsUtilities.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/11.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

/// 创建一个可变的路径
func CGPathCreate(rect: CGRect, radius: CGFloat) -> CGMutablePath {
    let x1 = rect.origin;
    let x2 = CGPoint.init(x: rect.origin.x + rect.size.width, y: rect.origin.y);
    let x3 = CGPoint.init(x:rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height);
    let x4 = CGPoint.init(x:rect.origin.x, y: rect.origin.y + rect.size.height);
    
    let y1 = CGPoint.init(x:rect.origin.x + radius, y: rect.origin.y);
    let y2 = CGPoint.init(x:rect.origin.x + rect.size.width - radius, y: rect.origin.y);
    let y3 = CGPoint.init(x:rect.origin.x + rect.size.width, y: rect.origin.y + radius);
    let y4 = CGPoint.init(x:rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.width - radius);
    let y5 = CGPoint.init(x:rect.origin.x + rect.size.width - radius, y: rect.origin.y + rect.size.width);
    let y6 = CGPoint.init(x:rect.origin.x + radius, y: rect.origin.y + rect.size.width);
    let y7 = CGPoint.init(x:rect.origin.x, y: rect.origin.y + rect.size.width - radius);
    let y8 = CGPoint.init(x:rect.origin.x, y: rect.origin.y + radius);
    
    let pathRef = CGMutablePath();
    
    if (radius <= 0) {
        pathRef.move(to: x1, transform: CGAffineTransform.identity);
        pathRef.addLine(to: x2, transform: CGAffineTransform.identity);
        pathRef.addLine(to: x3, transform: CGAffineTransform.identity);
        pathRef.addLine(to: x4, transform: CGAffineTransform.identity);
    }else {
        pathRef.move(to: y1, transform: CGAffineTransform.identity);
        
        pathRef.addLine(to: y2, transform: CGAffineTransform.identity);
        pathRef.addArc(tangent1End: x2, tangent2End: y3, radius: radius);
        
        pathRef.addLine(to: y4, transform: CGAffineTransform.identity);
        pathRef.addArc(tangent1End: x3, tangent2End: y5, radius: radius);
        
        pathRef.addLine(to: y6, transform: CGAffineTransform.identity);
        pathRef.addArc(tangent1End: x4, tangent2End: y7, radius: radius);
        
        pathRef.addLine(to: y8, transform: CGAffineTransform.identity);
        pathRef.addArc(tangent1End: x1, tangent2End: y1, radius: radius);
    }
    pathRef.closeSubpath();
    return pathRef;
}

/// 创建多个点的路径
func CGPathCreate(point: CGPoint ...) -> CGMutablePath {
    let pathRef = CGMutablePath.init();
    
    for p in point {
        if p == point.first {
            pathRef.move(to: point.first!, transform: CGAffineTransform.identity);
        }else {
             pathRef.addLine(to: p, transform: CGAffineTransform.identity)
        }
    }
    pathRef.closeSubpath();
    return pathRef;
}

/// 画矩形
func JCDrawRectangle(rect: CGRect, color: UIColor) {
    let _contextRef = UIGraphicsGetCurrentContext();
    let _pathRef = CGPathCreate(rect: rect, radius: 0);
    _contextRef?.addPath(_pathRef);
    _contextRef?.setFillColor(color.cgColor);
    _contextRef?.drawPath(using: CGPathDrawingMode.fill);
}

/// 画虚线
func JCDrawDottedLine(p1: CGPoint, p2: CGPoint) {
    JCDrawColorDottedLine(p1: p1, p2: p2, color: UIColor.gray);
}

/// 画有颜色的虚线
func JCDrawColorDottedLine(p1: CGPoint, p2: CGPoint, color: UIColor) {
    let _contextRef = UIGraphicsGetCurrentContext();
    _contextRef?.beginPath();
    _contextRef?.setLineWidth(1);
    _contextRef?.setStrokeColor(color.cgColor);
    var lengths = Array<CGFloat>.init();
    lengths.append(1);
    lengths.append(8);
    _contextRef?.setLineDash(phase: 0, lengths: lengths);
    _contextRef?.move(to: p1);
    _contextRef?.addLine(to: p2);
}

/// 画直线
func JCDrawLine(p1: CGPoint, p2: CGPoint, width: CGFloat, color: UIColor) {
    JCDrawLineCap(p1: p1, p2: p2, width: width, color: color, cap: CGLineCap.round);
}

/// 画直线
func JCDrawLineCap(p1: CGPoint, p2: CGPoint, width: CGFloat, color: UIColor, cap: CGLineCap) {
    let _contextRef = UIGraphicsGetCurrentContext();
    _contextRef?.setLineCap(cap);
    _contextRef?.setLineWidth(width);
    color.setStroke();
    color.setFill();
    _contextRef?.move(to: p1);
    _contextRef?.addLine(to: p2);
    _contextRef?.strokePath();
}

/// 类似刮刮乐的效果
func JCImageScratch(layer: CALayer, size: CGSize, clearRect: CGRect) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    let ref = UIGraphicsGetCurrentContext();
    layer.render(in: ref!);
    ref?.clear(clearRect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 保留rect内的像素，之外不要，颜色为layer的背景颜色
func JCImagePictureClip(layer: CALayer, rect: CGRect) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0);
    let path = UIBezierPath.init(rect: rect);
    path.addClip();
    let ref = UIGraphicsGetCurrentContext();
    layer.render(in: ref!);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 画一条波浪纹
func JCWaveShapeLayer(shapeLayer: CAShapeLayer, amplitude: CGFloat, cycle: CGFloat, drift: CGFloat, size: CGSize) {
    let wavePath = JCWavePathRef(amplitude: amplitude, cycle: cycle, drift: drift, size: size);
    shapeLayer.path = wavePath;
}

/// 创建一条波浪纹路径
///
/// - Parameters:
///   - amplitude: 振幅
///   - cycle: 周期
///   - drift: 位移
///   - size: 波浪纹的高宽
/// - Returns: 路径
func JCWavePathRef(amplitude: CGFloat, cycle: CGFloat, drift: CGFloat, size: CGSize) -> CGMutablePath {
    let wavePath = CGMutablePath.init();
    var y = size.height;
    wavePath.move(to: CGPoint.init(x: 0, y: y));
    
    for i in 0...Int(size.width) {
        y = amplitude * sin(cycle * CGFloat(i) + drift) + size.height;
        wavePath.addLine(to: CGPoint.init(x: CGFloat(i), y: y))
    }
    
    wavePath.addLine(to: CGPoint.init(x: size.width, y: 0));
    wavePath.addLine(to: CGPoint.zero);
    wavePath.closeSubpath();
    return wavePath;
}
