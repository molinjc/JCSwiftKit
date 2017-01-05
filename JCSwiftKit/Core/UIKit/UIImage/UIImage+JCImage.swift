//
//  UIImage+JCImage.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2016/12/31.
//  Copyright © 2016年 molin. All rights reserved.
//

import UIKit
import ImageIO

extension UIImage {
    
    /// 原图
    func originalImage() -> UIImage {
        return self.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
    }
    
    /// 图片着色
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - rect: 范围
    ///   - alpha: 颜色的透明度 0~1
    /// - Returns: 新图片
    func tintedImage(color: UIColor, rect: CGRect, alpha: CGFloat) -> UIImage {
        let imageRect = CGRect(x:0.0, y:0.0, width:self.size.width, height:self.size.height);
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let ctx = UIGraphicsGetCurrentContext();
        self.draw(in: imageRect);
        ctx?.setFillColor(color.cgColor);
        ctx?.setAlpha(alpha);
        ctx?.setBlendMode(CGBlendMode.sourceAtop);
        ctx?.fill(rect);
        let imageRef = ctx?.makeImage();
        let darkImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation);
        UIGraphicsEndImageContext();
        return darkImage;
    }
    
    func tintedImage(color: UIColor) -> UIImage {
        return self.tintedImage(color: color, rect: CGRect(x:0.0, y:0.0, width:self.size.width, height:self.size.height), alpha: 1.0);
    }
    
    func tintedImage(color: UIColor, rect: CGRect) -> UIImage {
        return self.tintedImage(color: color, rect: rect, alpha: 1.0);
    }
    
    func tintedImage(color: UIColor, alpha: CGFloat) -> UIImage{
        return self.tintedImage(color: color, rect: CGRect(x:0.0, y:0.0, width:self.size.width, height:self.size.height), alpha: alpha);
    }
    
    /// 生成一张纯色的图片
    static func imageColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height);
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        let colorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return colorImage!;
    }
    
    /// 等比例缩放图片
    func toScale(scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: self.size.width * scale, height: self.size.height * scale));
        self.draw(in: CGRect.init(x: 0.0, y: 0.0, width: self.size.width * scale, height: self.size.height * scale));
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaleImage!;
    }
    
    /// 调整图片大小
    func resize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);
        self.draw(in: CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height));
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resizeImage!;
    }
    
    /// 设置图片圆角
    func imageCornerRadius(radius: CGFloat) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height);
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext();
        context?.addPath(UIBezierPath.init(roundedRect: rect, cornerRadius: radius).cgPath);
        self.draw(in: rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
}

extension UIImage {
    
    /// 根据Gif图片名生成UImage对象
    class func animatedGIF(name: String) -> UIImage {
        let retinaPath = Bundle.main.path(forResource: name, ofType: nil);
        let data = NSData.init(contentsOfFile: retinaPath!);
        if (data != nil) {
            return UIImage.animatedGIFWithData(data: data!);
        }
        return UIImage.init(named: name)!;
    }
    
    /// 根据Gif图片的data数据生成UIImage对象
    class func animatedGIFWithData(data: NSData) -> UIImage {
        if data.length <= 0 {
            return UIImage.init();
        }
        
        let source = CGImageSourceCreateWithData(data, nil);
        let count = CGImageSourceGetCount(source!);
        var animatedImage: UIImage;
        
        if count <= 1 {
            animatedImage = UIImage.init(data: data as Data)!;
        }else {
            var images = Array<UIImage>();
            var duration: Float = 0.0;
            var i = -1;
            for _ in 0...(count - 1) {
                i += 1;
                let image = CGImageSourceCreateImageAtIndex(source!, i, nil);
         
                // 计算时长
                var frameDuration: Float = 0.1;
                let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source!, i, nil);
                let frameProperties = cfFrameProperties as! NSDictionary;
                let gifProperties = frameProperties[kCGImagePropertyGIFDictionary as NSString] as! NSDictionary;
                let delayTimeUnclampedProp = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as NSString] as! NSNumber;
                
                if (delayTimeUnclampedProp.boolValue) {
                    frameDuration = Float(delayTimeUnclampedProp.floatValue);
                }else {
                    let delayTimeProp = gifProperties[kCGImagePropertyGIFDelayTime as NSString] as! NSNumber;
                    if (delayTimeProp.boolValue) {
                        frameDuration = Float(delayTimeProp.floatValue);
                    }
                }
                if (frameDuration < 0.011) {
                    frameDuration = 0.100;
                }
                
                duration += frameDuration;
                let im = UIImage.init(cgImage: image!, scale: CGFloat(duration), orientation: UIImageOrientation.up);
                images.append(im as UIImage);
            }
            
            if duration <= 0 {
                duration = Float(1.0 / 10.0) * Float(count);
            }
            animatedImage = UIImage.animatedImage(with: images, duration: Double(duration))!;
        }
        return animatedImage;
    }
}


// MARK: - QRCode
extension UIImage {
    
    /// 生成二维码图片
    class func QRCodeImage(text: String, size: CGFloat) -> UIImage {
        let stringData = text.description.data(using: String.Encoding.utf8);
        let QRFilter = CIFilter.init(name: "CIQRCodeGenerator");
        QRFilter?.setValue(stringData, forKey: "inputMessage");
        QRFilter?.setValue("M", forKey: "inputCorrectionLevel");
        let extent = QRFilter?.outputImage?.extent;
        
        let scale1 = size / (extent?.size.width)!;
        let scale2 = size / (extent?.size.height)!;
        var scale: CGFloat;
        if scale1 > scale2 {
            scale = scale2;
        }else {
            scale = scale1;
        }
        
        let width = (extent?.size.width)! * scale;
        let height = (extent?.size.height)! * scale;
        
        let cs = CGColorSpaceCreateDeviceGray();
        let bitmapRef = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue);
        
        let context = CIContext.init(options: nil);
        let bitmapImage = context.createCGImage((QRFilter?.outputImage)!, from: extent!);
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none;
        bitmapRef?.scaleBy(x: scale, y: scale);
        bitmapRef?.draw(bitmapImage!, in: extent!);
        
        let scaledImage = bitmapRef?.makeImage();
        let reusult = UIImage.init(cgImage: scaledImage!);
        return reusult;
    }
    
    /// 二维码图片内容信息
    func QRCodeImageContext() -> String? {
        let content = CIContext.init(options: nil);
        let detector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: content, options: nil);
        let cimage = CIImage.init(cgImage: self.cgImage!);
        let features = detector?.features(in: cimage);
        let f: CIQRCodeFeature = features?.first as! CIQRCodeFeature;
        return f.messageString!;
    }
}
