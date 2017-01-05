//
//  UIWebView+JCWebView.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/5.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit
import JavaScriptCore

// MARK: - HTML
extension UIWebView {
    
    /// 获取当前网页的URL
    func currentWebURL() -> String {
        return self.stringByEvaluatingJavaScript(from: "document.location.href")!;
    }
    
    /// 获取当前网页的标题
    func currentWebTitle() -> String {
        return self.stringByEvaluatingJavaScript(from: "document.title")!;
    }
    
    /// 获取当前网页的所有图片地址
    func currentWebAllImageURL() -> Array<String> {
        let allImageURL = self.stringByEvaluatingJavaScript(from: "var imgArray = document.getElementsByTagName('img'); var imgstr = ''; function f(){ for(var i = 0; i < imgArray.length; i++){ imgstr += imgArray[i].src;imgstr += ';';} return imgstr; } f();")!
        let imageURLArray = allImageURL.components(separatedBy: ";");
        return imageURLArray;
    }
    
    /// 获取当前网页的图片数量
    func currentWebImageNumber() -> Int {
        let imageNumber = self.stringByEvaluatingJavaScript(from: "var imgArray = document.getElementsByTagName('img');function f(){ var num=imgArray.length;return num;} f();");
        return (imageNumber as NSString?)!.integerValue;
    }
    
    /// 修改网页的背景颜色
    func changeWebBackgroundColor(color: UIColor) {
        self.stringByEvaluatingJavaScript(from: "document.body.style.backgroundColor = '\(color.stringForRGB16())'")
    }
}

var kJCJavaScript_JSContext = "kJCJavaScript_JSContext";


// MARK: - JavaScriptCore
extension UIWebView {
    
    var context: JSContext {
        get{
            var c: JSContext? = objc_getAssociatedObject(self, &kJCJavaScript_JSContext) as? JSContext;
            if (c == nil) {
                c = self.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext; // 获取web的JavaScript的环境
                objc_setAssociatedObject(self, &kJCJavaScript_JSContext, c, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return c!;
        }
    };
    
    
//    func javaScript(callback: String, achieved:@escaping (Array<Any>) -> Void) {
//        self.context[callback] = {
//            let
//        }();
//    }
}
