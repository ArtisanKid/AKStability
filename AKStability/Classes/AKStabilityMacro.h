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

//检测函数
#define AK_Try_Catch_Finally(_try, _catch, _finally)\
    @try {\
        _try;\
    } @catch (NSException *exception) {\
        NSLog(@"NSException:%@\n", exception);\
        _catch;\
    } @finally {\
        _finally;\
    }

#define AK_Try_Catch(_try, _catch)\
    @try { \
        _try; \
    } @catch (NSException *exception) { \
        NSLog(@"NSException:%@\n", exception); \
        _catch;\
    }

//nil和类型判断
#define AK_Nil_Return(_obj, _stuff, ...) \
    NSParameterAssert(_obj);\
    if(!_obj) {\
        _stuff;\
        return __VA_ARGS__;\
    }\

#define AK_Nil_Class(_obj, _canNil, _class) \
    if(!_canNil) {\
        NSParameterAssert(_obj);\
    }\
    if(_obj) {\
        NSParameterAssert([_obj isKindOfClass:_class.class]);\
    }

#define AK_Nil_Class_Return(_obj, _canNil, _class, _stuff, ...) \
    if(!_canNil) {\
        AK_Nil_Return(_obj, _stuff, __VA_ARGS__)\
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

//快速提醒
#define AK_Alert(INFO, ...)\
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(INFO), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

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

//weakify & strongify
#ifdef __OBJC__

    #if __has_feature(objc_arc)
        #if DEBUG
            #define ext_keywordify @autoreleasepool {}
        #else
            #define ext_keywordify @try {} @catch (...) {}
        #endif
    #endif

    #ifndef weakify
        #if __has_feature(objc_arc)
            #define weakify(x) \
                        ext_keywordify \
                        __attribute__((objc_ownership(weak))) \
                        __typeof__(x) self_weak_##x = (x);
        #endif
    #endif

    #ifndef strongify
        #if __has_feature(objc_arc)
            #define strongify(x) \
                        ext_keywordify \
                        _Pragma("clang diagnostic push") \
                        _Pragma("clang diagnostic ignored \"-Wshadow\"") \
                        __attribute__((objc_ownership(strong))) __typeof__(x) x = self_weak_##x; \
                        _Pragma("clang diagnostic pop")
        #endif
    #endif

#endif

#endif /* AKStabilityMacro_h */

#endif /* __OBJC__ */
