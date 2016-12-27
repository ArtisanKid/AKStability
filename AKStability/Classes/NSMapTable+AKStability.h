//
//  NSMapTable+AKStability.h
//  Pods
//
//  Created by 李翔宇 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>

@interface NSMapTable (AKStability)

- (NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *)AKStability_observersForTarget:(id)target;
- (NSMapTable<NSString *, NSNumber *> *)AKStability_keyPathsForObserver:(id)observer;

@end
