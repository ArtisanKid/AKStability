//
//  AKMacro.h
//  Pods
//
//  Created by 李翔宇 on 16/2/25.
//
//

#ifdef __OBJC__

#import <Foundation/Foundation.h>

#ifndef AKStabilityMacro_h
#define AKStabilityMacro_h

//************************************************************
//Note: 用于定义全局宏方法
//所有使用代码块的宏定义中，代码块必须包裹在{}，或者({})中，否则易出错误
//************************************************************

#if DEBUG
    #define AKStability_Log(_Format, ...) NSLog((@"\n[File:%s]\n[Line:%d]\n[Function:%s]\n" _Format @"\n"), __FILE__, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__);
#else
    #define AKStability_Log(_Format, ...)
#endif

//安全执行Block
#define AKStability_Exacute_Block(_blockName, ...) ({ !_blockName ? nil : _blockName(__VA_ARGS__); })

//取消警告
#define AKStability_Suppress_Warning(_warn, _stuff)\
    do {\
        _Pragma("clang diagnostic push")\
        _Pragma("clang diagnostic ignored "_warn"")\
        _stuff;\
        _Pragma("clang diagnostic pop")\
    } while(0)

//退出应用
#define AKStability_Exit\
    {\
        UIWindow *window = UIApplication.sharedApplication.delegate.window;\
        [UIView animateWithDuration:.65f animations: ^{\
            window.alpha = 0.f;\
        } completion:^(BOOL finished) {\
            exit(0);\
        }];\
    }

#endif /* AKStabilityMacro_h */

#endif /* __OBJC__ */
