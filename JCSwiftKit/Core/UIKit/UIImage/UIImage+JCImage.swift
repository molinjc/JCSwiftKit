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
    
    /// 灰度图片
    func grayImage() -> UIImage? {
        let colorSpace = CGColorSpaceCreateDeviceGray();
        let context = CGContext.init(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue);
        if (context == nil) {
            return nil;
        }
        
        context?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height));
        let grayImage = UIImage.init(cgImage: (context?.makeImage())!);
        return grayImage;
    }
    
    /// 取图片某点像素的颜色
    func color(atPixel: CGPoint) -> UIColor? {
        let width = self.size.width;
        let height = self.size.height;
        
        if !CGRect.init(x: 0, y: 0, width: width, height: height).contains(atPixel) {
            return nil;
        }
        
        let pointX = trunc(atPixel.x);  // 取整
        let pointY = trunc(atPixel.y);
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let bytesPerPixel = 4;
        let bytesPerRow = bytesPerPixel * 1;
        let bitsPerComponent = 8;
        var pixelData = Array<Int>.init();
        
        let context = CGContext.init(data: &pixelData, width: 1, height: 1, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: (CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue))
        
        context?.setBlendMode(CGBlendMode.copy);
        context?.translateBy(x: pointX, y: (pointY - height));
        context?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: width, height: height));
        
        let red = CGFloat(pixelData[0]) / 255.0;
        let green = CGFloat(pixelData[1]) / 255.0;
        let blue = CGFloat(pixelData[2]) / 255.0;
        let alpha = CGFloat(pixelData[3]) / 255.0;
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha);
    }
    
    /// 设置图片透明
    func imageByApplying(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        let ctx = UIGraphicsGetCurrentContext();
        let area = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height);
        ctx?.scaleBy(x: 1, y: -1);
        ctx?.translateBy(x: 0, y: -area.size.height);
        ctx?.setBlendMode(CGBlendMode.multiply);
        ctx?.setAlpha(alpha);
        ctx?.draw(self.cgImage!, in: area);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
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
    
    /// 所占的内存大小
    func memorySize() -> Int {
        return self.cgImage!.height * self.cgImage!.bytesPerRow;
    }
    
    /// 从中心向外拉伸
    func centerOutwardStretching() -> UIImage {
        return self.stretchableImage(withLeftCapWidth: Int(self.size.width * 0.5), topCapHeight: Int(self.size.height * 0.5));
    }
    
    /// 截取image里的rect区域内的图片
    func subimage(inRect: CGRect) -> UIImage? {
        let imageRef = self.cgImage!.cropping(to: inRect);
        return UIImage.init(cgImage: imageRef!);
    }
    
    /// 根据图片名设置图片方向
    class func image(named: String, orientation: UIImageOrientation) -> UIImage {
        let image = UIImage.init(named: named);
        return UIImage.init(cgImage: (image?.cgImage)!, scale: (image?.scale)!, orientation: orientation);
    }
    
    class func image(named: String, scale: CGFloat,orientation: UIImageOrientation) -> UIImage {
        let image = UIImage.init(named: named);
        return UIImage.init(cgImage: (image?.cgImage)!, scale: scale, orientation: orientation);
    }
    
    /// 根据图片路径设置图片方向
    class func imageWithContentsOfFile(path: String, orientation: UIImageOrientation) -> UIImage {
        let image = UIImage.init(contentsOfFile: path);
        return UIImage.init(cgImage: (image?.cgImage)!, scale: (image?.scale)!, orientation: orientation);
    }
    
    class func imageWithContentsOfFile(path: String, scale: CGFloat, orientation: UIImageOrientation) -> UIImage {
        let image = UIImage.init(contentsOfFile: path);
        return UIImage.init(cgImage: (image?.cgImage)!, scale: scale, orientation: orientation);
    }
    
    /// 设置图片方向
    func orientation(orientation: UIImageOrientation) -> UIImage {
        return UIImage.init(cgImage: self.cgImage!, scale: self.scale, orientation: orientation);
    }
    
    /// 水平翻转
    func flipHorizontal() -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        
        let ctx = UIGraphicsGetCurrentContext();
        ctx?.clip(to: rect);
        ctx?.rotate(by: CGFloat(M_PI));
        ctx?.translateBy(x: -rect.size.width, y: -rect.size.height);
        ctx?.draw(self.cgImage!, in: rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
    /// 垂直翻转
    func flipVertical() -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        
        let ctx = UIGraphicsGetCurrentContext();
        ctx?.clip(to: rect);
        ctx?.draw(self.cgImage!, in: rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
    /// 将图片旋转弧度radians
    func imageRotated(byRadians: CGFloat) -> UIImage? {
        let rotatedViewBox = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height));
        let t = CGAffineTransform.init(rotationAngle: byRadians);
        rotatedViewBox.transform = t;
        let rotatedSize = rotatedViewBox.frame.size;
        
        UIGraphicsBeginImageContext(rotatedSize);
        let bitmap = UIGraphicsGetCurrentContext();
        bitmap?.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2);
        bitmap?.rotate(by: byRadians);
        bitmap?.scaleBy(x: 1.0, y: -1.0);
        bitmap?.draw(self.cgImage!, in: CGRect.init(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height));
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    /// 将图片旋转角度degrees
    func imageRotated(byDegrees: CGFloat) -> UIImage? {
        return self.imageRotated(byRadians: CGFloat(Double(byDegrees) * M_PI / 180));
    }
    
    
    /// 图片上绘制文字
    ///
    /// - Parameters:
    ///   - text: 所要绘制的文字
    ///   - textColor: 文字的颜色
    ///   - font: 文字的字体
    ///   - paragraphStyle: 文字的样式
    /// - Returns: Image
     func image(text: String, textColor: UIColor, font: UIFont, paragraphStyle: NSParagraphStyle) -> UIImage? {
        let size = CGSize.init(width: self.size.width, height: self.size.height);
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);        // 创建一个基于位图的上下文
        self.draw(at: CGPoint.init(x: 0.0, y: 0.0));
        
        let textSize = text.sizeFor(font: font, size: self.size);
        let rect = CGRect.init(x: (size.width - textSize.width) / 2, y: (size.height - textSize.height) / 2, width: textSize.width, height: textSize.height);
        (text as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: font,
                                                           NSForegroundColorAttributeName:textColor,
                                                           NSParagraphStyleAttributeName:paragraphStyle]);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func image(text: String, textColor: UIColor, font: UIFont) -> UIImage? {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle;
        paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping;
        paragraphStyle.alignment = NSTextAlignment.center;
        return self.image(text: text, textColor: textColor, font: font, paragraphStyle: paragraphStyle);
    }
    
    func image(text: String, textColor: UIColor, fontSize: CGFloat, paragraphStyle: NSParagraphStyle) -> UIImage? {
        let font = UIFont.systemFont(ofSize: fontSize);
        return self.image(text: text, textColor: textColor, font: font, paragraphStyle: paragraphStyle);
    }
    
    func image(text: String, textColor: UIColor, fontSize: CGFloat) -> UIImage? {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle;
        paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping;
        paragraphStyle.alignment = NSTextAlignment.center;
        return self.image(text: text, textColor: textColor, fontSize: fontSize, paragraphStyle: paragraphStyle);
    }
    
    func image(text: String, fontSize: CGFloat) -> UIImage? {
        return self.image(text: text, textColor: UIColor.white, fontSize: fontSize);
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
