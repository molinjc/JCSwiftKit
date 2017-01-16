//
//  Data+JCData.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/13.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    
    /// Data转String
    func utf8String() -> String {
        return String.init(data: self, encoding: String.Encoding.utf8)!;
    }
    
    /// 从资源里获取data数据
    static func dataFor(resource: String, ofType: String) -> Data? {
        let path = Bundle.main.path(forResource: resource, ofType: ofType);
        if (path == nil) {
            return nil;
        }
        return try? Data.init(contentsOf: URL.init(string: path!)!);
    }
    
    static func dataFor(resource: String) -> Data? {
        return Data.dataFor(resource: resource, ofType: "");
    }
    
    /// 压缩图片成Data数据
    static func compressed(image: UIImage) -> Data? {
        return Data.compressed(image: image, quality: 1.0);
    }
    
    /// 根据压缩质量压缩图片成Data数据
    static func compressed(image: UIImage, quality: CGFloat) -> Data? {
        var data = UIImageJPEGRepresentation(image, quality);
        if (data == nil) {
            data = UIImagePNGRepresentation(image);
        }
        return data;
    }
    
    /// 压缩图片在设定的大小内
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - limitSize: 最大的大小
    /// - Returns: Data
    static func compressed(image: UIImage, limitSize: Int) -> Data? {
        let imagePixel = image.cgImage!.width * image.cgImage!.height;  // 图片像素
        let imageSize = imagePixel * (image.cgImage?.bitsPerPixel)! / (8 * 1024);
        if imageSize > limitSize {
            let compressedParam = CGFloat(limitSize) / CGFloat(imageSize);
            return UIImageJPEGRepresentation(image, compressedParam);
        }
        return UIImagePNGRepresentation(image);
    }
    
    static func compressedTo100K(image: UIImage) -> Data? {
        return Data.compressed(image: image, limitSize: 100);
    }
    
    static func compressedTo500K(image: UIImage) -> Data? {
        return Data.compressed(image: image, limitSize: 500);
    }
}
