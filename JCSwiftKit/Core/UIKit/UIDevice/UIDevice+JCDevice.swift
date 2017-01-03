//
//  UIDevice+JCDevice.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/1.
//  Copyright © 2017年 molin. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /// 是否是iPad设备
    func isPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad;
    }
    
    /// 是否是iPhone设备
    func isPhone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone;
    }
    
    /*
    func isSimulator() -> Bool {
        return false;
    }
    
    func machineModel() -> String {
        var size: size_t;
        sysctlbyname("hw.machine", nil, &size, nil, 0);
        let machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, nil, 0);
        let model = String.init(utf8String: machine);
        free(machine);
        return model;
    }
     */
    
    func machineModel() -> String {
        var systemInfo = utsname();
        uname(&systemInfo);
        let machineMirror = Mirror(reflecting: systemInfo.machine);
        let identifier = machineMirror.children.reduce("")
        { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier;
    }
    
    func machineModelName() -> String {
        let model = self.machineModel();

        let dic = [ "Watch1,1" : "Apple Watch",
                    "Watch1,2" :  "Apple Watch",
              
                    "iPod1,1" :  "iPod touch 1",
                    "iPod2,1" :  "iPod touch 2",
                    "iPod3,1" :  "iPod touch 3",
                    "iPod4,1" :  "iPod touch 4",
                    "iPod5,1" :  "iPod touch 5",
                    "iPod7,1" :  "iPod touch 6",
                    
                    "iPhone1,1" :  "iPhone 1G",
                    "iPhone1,2" :  "iPhone 3G",
                    "iPhone2,1" :  "iPhone 3GS",
                    "iPhone3,1" :  "iPhone 4 (GSM)",
                    "iPhone3,2" :  "iPhone 4",
                    "iPhone3,3" :  "iPhone 4 (CDMA)",
                    "iPhone4,1" :  "iPhone 4S",
                    "iPhone5,1" :  "iPhone 5",
                    "iPhone5,2" :  "iPhone 5",
                    "iPhone5,3" :  "iPhone 5c",
                    "iPhone5,4" :  "iPhone 5c",
                    "iPhone6,1" :  "iPhone 5s",
                    "iPhone6,2" :  "iPhone 5s",
                    "iPhone7,1" :  "iPhone 6 Plus",
                    "iPhone7,2" :  "iPhone 6",
                    "iPhone8,1" :  "iPhone 6s",
                    "iPhone8,2" :  "iPhone 6s Plus",
                  
                    "iPad1,1" :  "iPad 1",
                    "iPad2,1" :  "iPad 2 (WiFi)",
                    "iPad2,2" :  "iPad 2 (GSM)",
                    "iPad2,3" :  "iPad 2 (CDMA)",
                    "iPad2,4" :  "iPad 2",
                    "iPad2,5" :  "iPad mini 1",
                    "iPad2,6" :  "iPad mini 1",
                    "iPad2,7" :  "iPad mini 1",
                    "iPad3,1" :  "iPad 3 (WiFi)",
                    "iPad3,2" :  "iPad 3 (4G)",
                    "iPad3,3" :  "iPad 3 (4G)",
                    "iPad3,4" :  "iPad 4",
                    "iPad3,5" :  "iPad 4",
                    "iPad3,6" :  "iPad 4",
                    "iPad4,1" :  "iPad Air",
                    "iPad4,2" :  "iPad Air",
                    "iPad4,3" :  "iPad Air",
                    "iPad4,4" :  "iPad mini 2",
                    "iPad4,5" :  "iPad mini 2",
                    "iPad4,6" :  "iPad mini 2",
                    "iPad4,7" :  "iPad mini 3",
                    "iPad4,8" :  "iPad mini 3",
                    "iPad4,9" :  "iPad mini 3",
                    "iPad5,1" :  "iPad mini 4",
                    "iPad5,2" :  "iPad mini 4",
                    "iPad5,3" :  "iPad Air 2",
                    "iPad5,4" :  "iPad Air 2",
                                                                
                    "i386" :  "Simulator x86",
                    "x86_64" :  "Simulator x64",];
        
        var name = dic[model];
        if (name == nil) {
            name = model;
        }
        return name!;
    }
    
    /// 系统启动时间
    func systemUptime() -> Date {
        let time = ProcessInfo.processInfo.systemUptime;
        return Date.init(timeIntervalSinceNow: (0 - time));
    }
//    
//    func ipAddressWIFI() -> String {
//        var address: String;
//        
//    }
}
