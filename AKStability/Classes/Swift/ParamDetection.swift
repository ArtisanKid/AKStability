//
//  ParamDetection.swift
//  Pods
//
//  Created by 李翔宇 on 2017/3/8.
//
//

import Foundation

public func stringNilableDetection(_ _string: String?, _ nilable: Bool) -> Bool {
    if let string = _string {
        guard string is String else {
            assertionFailure()
            return false
        }
        
        if !nilable {
            guard string.characters.count > 0 else {
                assertionFailure()
                return false
            }
        }
    } else if(!nilable) {
        assertionFailure()
    }
    return true
}

public func objectNilableDetection(_ _object: AnyObject?, _ _class: AnyClass, _ nilable: Bool) -> Bool {
    if let object = _object {
        guard type(of: object) == _class else {
            assertionFailure()
            return false
        }
    } else if(!nilable) {
        assertionFailure()
    }
    return true
}
