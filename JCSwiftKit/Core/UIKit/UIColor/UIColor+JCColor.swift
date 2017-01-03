//
//  UIColor+JCColor.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/1.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 十六进制
    class func colorRGB16(value: __uint32_t) -> UIColor {
        return UIColor.colorRGB16(value: value, alphe: 1.0);
    }
    
    /// 十六进制
    class func colorRGB16(value: __uint32_t, alphe: CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((value & 0xFF00) >> 8) / 255.0,
                            blue: CGFloat((value & 0xFF)) / 255.0,
                            alpha: alphe);
    }
    
    func RGB_red() -> CGFloat {
        let r = self.cgColor.components
        return r![0];
    }
    
    func RGB_green() -> CGFloat {
        let g = self.cgColor.components;
        if (self.cgColor.colorSpace?.model == CGColorSpaceModel.monochrome) {
            return g![0];
        }
        return g![1];
    }
    
    func RGB_blue() -> CGFloat {
        let b = self.cgColor.components;
        if (self.cgColor.colorSpace?.model == CGColorSpaceModel.monochrome) {
            return b![0];
        }
        return b![2];
    }
    
    func alpha() -> CGFloat {
        return self.cgColor.alpha;
    }
    
    /// 将颜色转换成16进制的字符串
    func stringForRGB16() -> String {
        let r = Int(self.RGB_red() * 255);
        let g = Int(self.RGB_green() * 255);
        let b = Int(self.RGB_blue() * 255);
        let stringColor = String.init(format: "#%02X%02X%02X", r, g, b);
        return stringColor;
    }
    
    /// 随机颜色，透明度默认1
    class func randomColor() -> UIColor {
        return UIColor.randomColor(alpha: 1.0);
    }
    
    // 随机颜色
    class func randomColor(alpha: CGFloat) -> UIColor {
        let redValue = arc4random() % 255;
        let greenValue = arc4random() % 255;
        let blueValue = arc4random() % 255;
        return UIColor.init(red: CGFloat(redValue) / 255.0, green: CGFloat(greenValue) / 255.0, blue: CGFloat(blueValue) / 255.0, alpha: alpha);
        
    }
    
    /// 薄雾玫瑰
    class func mistyRose() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFE4E1);
    }
    
    /// 浅鲑鱼色
    class func lightSalmon() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFA07A);
    }
    
    /// 淡珊瑚色
    class func lightCoral() -> UIColor {
        return UIColor.colorRGB16(value: 0xF08080);
    }
    
    /// 鲑鱼色
    class func salmonColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFA8072);
    }
    
    /// 珊瑚色
    class func coralColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFF7F50);
    }
    
    /// 番茄
    class func tomatoColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFF6347);
    }
    
    /// 橙红色
    class func orangeRed() -> UIColor {
        return UIColor.colorRGB16(value: 0xFF4500);
    }
    
    /// 印度红
    class func indianRed() -> UIColor {
        return UIColor.colorRGB16(value: 0xCD5C5C);
    }
    
    /// 猩红
    class func crimsonColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xDC143C);
    }
    
    /// 耐火砖
    class func fireBrick() -> UIColor {
        return UIColor.colorRGB16(value: 0xB22222);
    }
    
    /// 玉米色
    class func cornColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFF8DC);
    }
    
    /// 柠檬薄纱
    class func LemonChiffon() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFFACD);
    }
    
    /// 苍金麒麟
    class func paleGodenrod() -> UIColor {
        return UIColor.colorRGB16(value: 0xEEE8AA);
    }
    
    /// 卡其色
    class func khakiColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xF0E68C);
    }
    
    /// 金色
    class func goldColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFD700);
    }
    
    /// 雌黄
    class func orpimentColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFC64B);
    }
    
    /// 藤黄
    class func gambogeColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFB61E);
    }
    
    /// 雄黄
    class func realgarColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xE9BB1D);
    }
    
    /// 金麒麟色
    class func goldenrod() -> UIColor {
        return UIColor.colorRGB16(value: 0xDAA520);
    }
    
    /// 乌金
    class func darkGold() -> UIColor {
        return UIColor.colorRGB16(value: 0xA78E44);
    }
    
    /// 苍绿
    class func paleGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x98FB98);
    }
}
