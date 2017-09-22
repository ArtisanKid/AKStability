//
//  AKParamDetection.h
//  Pods
//
//  Created by 李翔宇 on 2017/3/4.
//
//

#import <Foundation/Foundation.h>
#import "AKStabilityMacros.h"

//_stuff传入{}(代码块)

#define AKStability_String_Nilable_Return(_string, _nilable, _stuff, ...) \
    do {\
        NSString *string = (NSString *)(_string);\
        if(string) {\
            if(![string isKindOfClass:[NSString class]]) {\
                NSAssert(0, nil);\
                _stuff;\
                return __VA_ARGS__;\
            }\
            \
            if(!_nilable) {\
                if(!string.length) {\
                    NSAssert(0, nil);\
                    _stuff;\
                    return __VA_ARGS__;\
                }\
            }\
        } else if(!_nilable) {\
            NSAssert(0, nil);\
            _stuff;\
            return __VA_ARGS__;\
        }\
    } while(0)

#define AKStability_Object_Class_Nilable_Return(_object, _class, _nilable, _stuff, ...) \
    do {\
        id object = (_object);\
        if(object) {\
            if(![object isKindOfClass:[_class class]]) {\
                NSAssert(0, nil);\
                _stuff;\
                return __VA_ARGS__;\
            }\
        } else if(!_nilable) {\
            NSAssert(0, nil);\
            _stuff;\
            return __VA_ARGS__;\
        }\
    } while(0)

@interface AKParamDetection : NSObject

@end
