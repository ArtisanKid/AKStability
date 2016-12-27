//
//  NSObject+AKStability.m
//  Pods
//
//  Created by 李翔宇 on 2016/12/18.
//
//

#import "NSObject+AKStability.h"
#import <objc/runtime.h>
#import "AKStabilityKVOProtector.h"

@implementation NSObject (AKStability)

static __attribute__((constructor)) void AKStability_hookObjectKVO() {
    Class NSObjectClass = [NSObject class];
    
    Method ori_method = class_getInstanceMethod(NSObjectClass, @selector(addObserver:forKeyPath:options:context:));
    Method hook_method = class_getInstanceMethod(NSObjectClass, @selector(AKStability_addObserver:forKeyPath:options:context:));
    method_exchangeImplementations(ori_method, hook_method);
    
    ori_method = class_getInstanceMethod(NSObjectClass, @selector(removeObserver:forKeyPath:context:));
    hook_method = class_getInstanceMethod(NSObjectClass, @selector(AKStability_removeObserver:forKeyPath:context:));
    method_exchangeImplementations(ori_method, hook_method);
    
    ori_method = class_getInstanceMethod(NSObjectClass, @selector(removeObserver:forKeyPath:));
    hook_method = class_getInstanceMethod(NSObjectClass, @selector(AKStability_removeObserver:forKeyPath:));
    method_exchangeImplementations(ori_method, hook_method);
}

- (void)AKStability_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if(!observer) {
        return;
    }
    
    if(!keyPath.length) {
        return;
    }
    
    if (self.AKStability_isCustomClass || observer.AKStability_isCustomClass) {
        [AKStabilityKVOProtector.protector bindTarget:self observer:observer keyPath:keyPath];
    }
    [self AKStability_addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)AKStability_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    if(!observer) {
        return;
    }
    
    if(!keyPath.length) {
        return;
    }
    
    if (self.AKStability_isCustomClass || observer.AKStability_isCustomClass) {
        [AKStabilityKVOProtector.protector unbindTarget:self observer:observer keyPath:keyPath];
    }
    [self AKStability_removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)AKStability_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    if(!observer) {
        return;
    }
    
    if(!keyPath.length) {
        return;
    }
    
    if (self.AKStability_isCustomClass || observer.AKStability_isCustomClass) {
        [AKStabilityKVOProtector.protector unbindTarget:self observer:observer keyPath:keyPath];
    }
    [self AKStability_removeObserver:observer forKeyPath:keyPath];
}

- (BOOL)AKStability_isCustomClass {
    NSBundle *selfBundle = [NSBundle bundleForClass:[self class]];
    return selfBundle == NSBundle.mainBundle;
}

- (void)AKStability_removeAllObservers {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMapTable *observerMapTable = [AKStabilityKVOProtector.protector.KVOMapTable objectForKey:self];
        id observer = nil;
        NSEnumerator *observerEnumerator = [observerMapTable keyEnumerator];
        while(observer = observerEnumerator.nextObject) {
            NSMapTable *keyPathMapTable = [observerMapTable objectForKey:observer];
            NSString *keyPath = nil;
            NSEnumerator *keyPathEnumerator = [keyPathMapTable keyEnumerator];
            while (keyPath = keyPathEnumerator.nextObject) {
                NSNumber *times = [keyPathMapTable objectForKey:keyPath];
                for(NSUInteger i = 0; i < times.integerValue; i++) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self removeObserver:observer forKeyPath:keyPath];
                    });
                }
            }
        }
    });
}

- (void)AKStability_implementCopy {
    Class selfClass = [self class];
    
    Method ori_method = class_getInstanceMethod(selfClass, @selector(copyWithZone:));
    if(ori_method) {
        return;
    }
    
    const char *types = method_getTypeEncoding(ori_method);
    IMP new_IMP = class_getMethodImplementation(selfClass, @selector(AKStability_copyWithZone:));
    class_addMethod(selfClass, @selector(copyWithZone:), new_IMP, types);
}

- (id)AKStability_copyWithZone:(nullable NSZone *)zone {
    Class selfClass = [self class];
    id _self = [[selfClass alloc] init];
    return _self;
}

@end

