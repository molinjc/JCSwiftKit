//
//  JCSwiftKitMacro.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/3.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation
import UIKit

public func JCClassFromString(_ aClassName: String) ->Swift.AnyClass? {
    let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String;
    return NSClassFromString("\(bundleName).\(aClassName)");
}

public func JCLog<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line) {
    print("🛠 行号:\(lineNumber)\n🛠 类文件:\(fileName)\n🛠 方法:\(methodName)\n🛠 内容:\(message)\n");
}
