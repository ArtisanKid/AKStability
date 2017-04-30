//
//  NSMapTable+AKStability.h
//  Pods
//
//  Created by 李翔宇 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>

@interface NSMapTable (AKStability)


/**
 获取目标对象的所有观察者

 @param target 目标对象
 @return 观察者字典
 */
- (NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *)AKStability_observersForTarget:(id)target;
- (NSMapTable<NSString *, NSNumber *> *)AKStability_keyPathsForObserver:(id)observer;

@end
