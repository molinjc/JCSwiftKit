//
//  URL+JCURL.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/20.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension URL {
    
    func parameters() -> Dictionary<String, Any> {
        var parametersDictionary = Dictionary<String, Any>.init();
        let queryComponents = self.query?.components(separatedBy: "&");
        for queryComponent in queryComponents! {
            let components = queryComponent.components(separatedBy: "=");
            let key = components.first
            let value = components.last;
            parametersDictionary[key!] = value;
        }
        return parametersDictionary;
    }
}
