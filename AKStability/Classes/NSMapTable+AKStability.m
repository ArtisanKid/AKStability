//
//  NSMapTable+AKStability.m
//  Pods
//
//  Created by 李翔宇 on 2016/12/24.
//
//

#import "NSMapTable+AKStability.h"

@implementation NSMapTable (AKStability)

- (NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *)AKStability_observersForTarget:(id)target {
    if(!target) {
        return nil;
    }
    
    NSMapTable *observerMapTable = [self objectForKey:target];
    if(!observerMapTable) {
        observerMapTable = [NSMapTable strongToStrongObjectsMapTable];
        [self setObject:observerMapTable forKey:target];
    }
    return observerMapTable;
}

- (NSMapTable<NSString *, NSNumber *> *)AKStability_keyPathsForObserver:(id)observer {
    if(!observer) {
        return nil;
    }
    
    NSMapTable *keyPathMapTable = [self objectForKey:observer];
    if(!keyPathMapTable) {
        keyPathMapTable = [NSMapTable strongToStrongObjectsMapTable];
        [self setObject:keyPathMapTable forKey:observer];
    }
    return keyPathMapTable;
}

@end
