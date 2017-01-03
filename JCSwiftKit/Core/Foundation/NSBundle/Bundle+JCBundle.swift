//
//  NSBundle+JCBundle.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/2.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 最小适配的系统版本
    func minimumOSVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "MinimumOSVersion") as! String;
    }
    
    /// 项目名
    func bundleName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String;
    }
    
    /// 项目版本号
    func bundleShortVersionString() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String;
    }
    
    /// 项目的Icon文件
    func bundleIconFile() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile") as! String;
    }
    
}
