//
//  FileManager+JCFileManager.swift
//  JCSwiftKitDemo
//
//  Created by molin.JC on 2017/1/22.
//  Copyright © 2017年 molin. All rights reserved.
//

import Foundation

extension FileManager {
    
    /// 根据文件路径获取文件的属性
    ///
    /// - Parameter ofPath: 文件路径
    /// - Returns: 文件属性
    static func fileAttributes(ofPath: String) -> Dictionary<FileAttributeKey, Any> {
        return try! FileManager.default.attributesOfItem(atPath: ofPath);
    }
    
    /// 根据文件的路径获取文件的大小
    static func fileSize(ofPath: String) -> Float {
        return FileManager.fileAttributes(ofPath: ofPath)[FileAttributeKey.size] as! Float
    }
    
    /// 删除指定路径
    static func delete(ofPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: ofPath) {
            do {
                try FileManager.default.removeItem(atPath: ofPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 创建指定路径
    static func createFolder(ofPath: String) -> Bool {
        if !FileManager.default.fileExists(atPath: ofPath) {
            do {
                try FileManager.default.createDirectory(atPath: ofPath, withIntermediateDirectories: true, attributes: nil);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 创建指定文件路径和内容
    static func createFile(ofPath: String, data: Data?) -> Bool {
        if !FileManager.default.fileExists(atPath: ofPath) {
            if FileManager.default.createFile(atPath: ofPath, contents: data, attributes: nil) {
                return true;
            }
            return false;
        }
        return false;
    }
    
    /// 移动文件，从path移动到aimsPath
    static func move(path: String, toAimsPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.moveItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 复制文件到指定路径
    static func copy(path: String, toAimsPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.copyItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 重命名文件
    static func rename(path: String, name: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            let toAimsPath = "\((path as NSString).deletingLastPathComponent)/\(name)";
            
            do {
                try FileManager.default.moveItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
}
