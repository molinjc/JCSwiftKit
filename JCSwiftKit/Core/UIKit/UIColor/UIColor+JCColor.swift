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
    
    
    /// 随机颜色
    class func randomColor(alpha: CGFloat) -> UIColor {
        let redValue = arc4random() % 255;
        let greenValue = arc4random() % 255;
        let blueValue = arc4random() % 255;
        return UIColor.init(red: CGFloat(redValue) / 255.0, green: CGFloat(greenValue) / 255.0, blue: CGFloat(blueValue) / 255.0, alpha: alpha);
        
    }
}


// MARK: - 色系
extension UIColor {
    
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
    
    /// 淡绿色
    class func lightGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x90EE90);
    }
    
    /// 春绿
    class func springGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x2AFD84);
    }
    
    /// 草坪绿
    class func lawnGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x7CFC00);
    }
    
    /// 酸橙绿
    class func limeColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x00FF00);
    }
    
    /// 森林绿
    class func forestGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x228B22);
    }
    
    /// 海洋绿
    class func seaGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x2E8B57);
    }
    
    /// 深绿
    class func darkGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x006400);
    }
    
    /// 橄榄(墨绿)
    class func olive() -> UIColor {
        return UIColor.colorRGB16(value: 0xE1FFFF);
    }
    
    /// 苍白绿松石
    class func paleTurquoise() -> UIColor {
        return UIColor.colorRGB16(value: 0xAFEEEE);
    }
    
    /// 绿碧
    class func aquamarine() -> UIColor {
        return UIColor.colorRGB16(value: 0x7FFFD4);
    }
    
    /// 绿松石
    class func turquoise() -> UIColor {
        return UIColor.colorRGB16(value: 0x40E0D0);
    }
    
    /// 适中绿松石
    class func mediumTurquoise() -> UIColor {
        return UIColor.colorRGB16(value: 0x48D1CC);
    }
    
    /// 美团色
    class func meituanColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x2BB8AA);
    }
    
    /// 浅海洋绿
    class func lightSeaGreen() -> UIColor {
        return UIColor.colorRGB16(value: 0x20B2AA);
    }
    
    /// 深青色
    class func darkCyan() -> UIColor {
        return UIColor.colorRGB16(value: 0x008B8B);
    }
    
    /// 水鸭色
    class func tealColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x008080);
    }
    
    /// 深石板灰
    class func darkSlateGray() -> UIColor {
        return UIColor.colorRGB16(value: 0x2F4F4F);
    }
    
    /// 天蓝色
    class func skyBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0xE1FFFF);
    }
    
    /// 淡蓝
    class func lightBLue() -> UIColor {
        return UIColor.colorRGB16(value: 0xADD8E6);
    }
    
    /// 深天蓝
    class func deepSkyBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x00BFFF);
    }
    
    /// 道奇蓝
    class func doderBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x1E90FF);
    }
    
    /// 矢车菊
    class func cornflowerBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x6495ED);
    }
    
    /// 皇家蓝
    class func royalBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x4169E1);
    }
    
    /// 适中的蓝色
    class func mediumBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x0000CD);
    }
    
    /// 深蓝
    class func darkBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x00008B);
    }
    
    /// 海军蓝
    class func navyColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x000080);
    }
    
    /// 午夜蓝
    class func midnightBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0x191970);
    }
    
    /// 薰衣草
    class func lavender() -> UIColor {
        return UIColor.colorRGB16(value: 0xE6E6FA);
    }
    
    /// 蓟
    class func thistleColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xD8BFD8);
    }
    
    /// 李子
    class func plumColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xDDA0DD);
    }
    
    /// 紫罗兰
    class func violetColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xEE82EE);
    }
    
    /// 适中的兰花紫
    class func mediumOrchid() -> UIColor {
        return UIColor.colorRGB16(value: 0xBA55D3);
    }
    
    /// 深兰花紫
    class func darkOrchid() -> UIColor {
        return UIColor.colorRGB16(value: 0x9932CC);
    }
    
    /// 深紫罗兰色
    class func darkVoilet() -> UIColor {
        return UIColor.colorRGB16(value: 0x9400D3);
    }
    
    /// 泛蓝紫罗兰
    class func blueViolet() -> UIColor {
        return UIColor.colorRGB16(value: 0x8A2BE2);
    }
    
    /// 深洋红色
    class func darkMagenta() -> UIColor {
        return UIColor.colorRGB16(value: 0x8B008B);
    }
    
    /// 靛青
    class func indigoColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x4B0082);
    }
    
    /// 白烟
    class func whiteSmoke() -> UIColor {
        return UIColor.colorRGB16(value: 0xF5F5F5);
    }
    
    /// 鸭蛋
    class func duckEgg() -> UIColor {
        return UIColor.colorRGB16(value: 0xE0EEE8);
    }
    
    /// 亮灰
    class func gainsboroColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xDCDCDC);
    }
    
    /// 蟹壳青
    class func carapaceColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xBBCDC5);
    }
    
    /// 银白色
    class func silverColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xC0C0C0);
    }
    
    /// 暗淡的灰色
    class func dimGray() -> UIColor {
        return UIColor.colorRGB16(value: 0x696969);
    }
    
    /// 海贝壳
    class func seaShell() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFF5EE);
    }
    
    /// 雪
    class func snowColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFFAFA);
    }
    
    /// 亚麻色
    class func linenColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFAF0E6);
    }
    
    /// 花之白
    class func floralWhite() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFFAF0);
    }
    
    /// 老饰带
    class func oldLace() -> UIColor {
        return UIColor.colorRGB16(value: 0xFDF5E6);
    }
    
    /// 象牙白
    class func ivoryColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFFFF0);
    }
    
    /// 蜂蜜露
    class func honeydew() -> UIColor {
        return UIColor.colorRGB16(value: 0xF0FFF0);
    }
    
    /// 薄荷奶油
    class func mintCream() -> UIColor {
        return UIColor.colorRGB16(value: 0xF5FFFA);
    }
    
    /// 蔚蓝色
    class func azureColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xF0FFFF);
    }
    
    /// 爱丽丝蓝
    class func aliceBlue() -> UIColor {
        return UIColor.colorRGB16(value: 0xF0F8FF);
    }
    
    /// 幽灵白
    class func ghostWhite() -> UIColor {
        return UIColor.colorRGB16(value: 0xF8F8FF);
    }
    
    /// 淡紫红
    class func lavenderBlush() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFF0F5);
    }
    
    /// 米色
    class func beigeColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xF5F5DD);
    }
    
    /// 黄褐色
    class func tanColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xD2B48C);
    }
    
    /// 玫瑰棕色
    class func rosyBrown() -> UIColor {
        return UIColor.colorRGB16(value: 0xBC8F8F);
    }
    
    /// 秘鲁
    class func peruColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xCD853F);
    }
    
    /// 巧克力
    class func chocolateColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xD2691E);
    }
    
    /// 古铜色
    class func bronzeColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xB87333);
    }
    
    /// 黄土赭色
    class func siennaColor() -> UIColor {
        return UIColor.colorRGB16(value: 0xA0522D);
    }
    
    /// 马鞍棕色
    class func saddleBrown() -> UIColor {
        return UIColor.colorRGB16(value: 0x8B4513);
    }
    
    /// 土棕
    class func soilColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x734A12);
    }
    
    /// 栗色
    class func maroonColor() -> UIColor {
        return UIColor.colorRGB16(value: 0x800000);
    }
    
    /// 乌贼墨棕
    class func inkfishBrown() -> UIColor {
        return UIColor.colorRGB16(value: 0x5E2612);
    }
    
    /// 水粉
    class func waterPink() -> UIColor {
        return UIColor.colorRGB16(value: 0xF3D3E7);
    }
    
    /// 藕色
    class func lotusRoot() -> UIColor {
        return UIColor.colorRGB16(value: 0xEDD1D8);
    }
    
    /// 浅粉红
    class func lightPink() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFB6C1);
    }
    
    /// 适中的粉红
    class func mediumPink() -> UIColor {
        return UIColor.colorRGB16(value: 0xFFC0CB);
    }
    
    /// 桃红
    class func peachRed() -> UIColor {
        return UIColor.colorRGB16(value: 0xF47983);
    }
    
    /// 苍白的紫罗兰红色
    class func paleVioletRed() -> UIColor {
        return UIColor.colorRGB16(value: 0xDB7093);
    }
    
    /// 深粉色
    class func deepPink() -> UIColor {
        return UIColor.colorRGB16(value: 0xFF1493);
    }
}
