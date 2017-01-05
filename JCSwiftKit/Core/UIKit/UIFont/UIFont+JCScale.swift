//
//  UIFont+JCScale.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/1.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// systemFontOfSize:
    class func scaleFont(ofSize: CGFloat) -> UIFont {
        let size = ofSize * UIScreen.main._scale_;
        return UIFont.systemFont(ofSize: size);
    }
    
    /// fontWithName:size:
    class func scaleFont(name: String, ofSize: CGFloat) -> UIFont {
        let size = ofSize * UIScreen.main._scale_;
        return UIFont.init(name: name, size: size)!;
    }
    
    /// 粗体
    class func fontNameWithHelveticaBold(size: CGFloat) -> UIFont {
        return UIFont.scaleFont(name: "Helvetica-Bold", ofSize: size);
    }
    
    /// 斜体
    class func fontNameWithHelveticaOblique(size: CGFloat) -> UIFont {
        return UIFont.scaleFont(name: "Helvetica-Oblique", ofSize: size);
    }
    
    /// 加载本地TTF字体, 字体大小默认15.0f
    class func fontWithTTF(atPath: String) -> UIFont {
        return UIFont.fontWithTTF(atPath: atPath, size: 15.0);
    }

    /// 加载本地TTF字体
    class func fontWithTTF(atPath: String, size: CGFloat) -> UIFont {
        let foundFile = FileManager.default.fileExists(atPath: atPath);
        if !foundFile {
            return UIFont.systemFont(ofSize: size);
        }
        
        let fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, atPath as CFString!, CFURLPathStyle.cfurlposixPathStyle, false);
        let dataProvider = CGDataProvider.init(url: fontURL!);
        let graphicsFont = CGFont.init(dataProvider!);
        let smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, nil, nil);
        return smallFont as UIFont;
    }
}
