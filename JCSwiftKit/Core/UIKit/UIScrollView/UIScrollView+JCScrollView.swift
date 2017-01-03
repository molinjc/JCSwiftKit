//
//  UIScrollView+JCScrollView.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/3.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    /// 滚到顶点
    func scrollToTop(animated: Bool) {
        var off = self.contentOffset;
        off.y = 0 - self.contentInset.top;
        self.setContentOffset(off, animated: animated);
    }
    
    func scrollToTop_func() {
        self.scrollToTop(animated: true);
    }
    
    /// 滚到底边
    func scrollToBottem(animated: Bool) {
        var off = self.contentOffset;
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
        self.setContentOffset(off, animated: animated);
    }
    
    func scrollToBottem() {
        self.scrollToBottem(animated: true);
    }
    
    /// 滚到左边
    func scrollToLeft(animated: Bool) {
        var off = self.contentOffset;
        off.x = 0 - self.contentInset.left;
        self.setContentOffset(off, animated: animated);
    }
    
    func scrollToLeft() {
        self.scrollToLeft(animated: true);
    }
    
    /// 滚到右边
    func scrollToRight(animated: Bool) {
        var off = self.contentOffset;
        off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
        self.setContentOffset(off, animated: animated);
    }
    
    func scrollToRight() {
        self.scrollToRight(animated: true);
    }
}
