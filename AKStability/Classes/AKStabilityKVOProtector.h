//
//  AKStabilityKVOProtector.h
//  Pods
//
//  Created by 李翔宇 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKStabilityKVOProtector : NSObject

#pragma mark- Singleton Method
@property (class, nonatomic, strong, readonly) AKStabilityKVOProtector *protector;

- (void)bindTarget:(id)target observer:(id)observer keyPath:(NSString *)keyPath;
- (void)unbindTarget:(id)target observer:(id)observer keyPath:(NSString *)keyPath;

//{target:{observer:{keyPath:count}}}
@property (nonatomic, strong, readonly) NSMapTable<id, NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *> *KVOMapTable;
- (NSString *)kvoRelations;

@end

NS_ASSUME_NONNULL_END
