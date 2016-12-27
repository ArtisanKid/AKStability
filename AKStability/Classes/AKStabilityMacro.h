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

//nil和类型判断
#define AK_Nilable_Class_Return(_obj, _nilable, _class, _stuff, ...) \
    if(!_nilable) {\
        NSParameterAssert(_obj);\
        if(!_obj) {\
            _stuff;\
            return __VA_ARGS__;\
        }\
    }\
    if(_obj) {\
        NSParameterAssert([_obj isKindOfClass:_class.class]);\
        if(![_obj isKindOfClass:_class.class]) {\
            _stuff;\
            return __VA_ARGS__;\
        }\
    }

//安全执行Block
#define AK_Exacute_Block(_blockName, ...) ({ !_blockName ? nil : _blockName(__VA_ARGS__); })

//取消警告
#define AK_Suppress_Warning(_warn, _stuff)\
    do {\
        _Pragma("clang diagnostic push")\
        _Pragma("clang diagnostic ignored "_warn"")\
        _stuff;\
        _Pragma("clang diagnostic pop")\
    } while(0)

//退出应用
#define AK_Exit\
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
