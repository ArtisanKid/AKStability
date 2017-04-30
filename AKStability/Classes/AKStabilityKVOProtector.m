//
//  NSStabilityKVOProtector.m
//  Pods
//
//  Created by 李翔宇 on 2016/12/24.
//
//

#import "AKStabilityKVOProtector.h"
#import "NSMapTable+AKStability.h"
#import "NSObject+AKStability.h"

@interface AKStabilityKVOProtector ()

//{observer:{target:{keyPath:count}}}
@property (nonatomic, strong) NSMapTable<id, NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *> *KVOMapTable;

@end

@implementation AKStabilityKVOProtector

#pragma mark- Singleton Method
+ (AKStabilityKVOProtector *)protector {
    static AKStabilityKVOProtector *protector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        protector = [[super allocWithZone:NULL] init];
        protector.KVOMapTable = [NSMapTable strongToStrongObjectsMapTable];
    });
    return protector;
}

+ (id)alloc {
    return [self protector];
}

+ (id)allocWithZone:(NSZone * _Nullable)zone {
    return [self protector];
}

- (id)copy {
    return self;
}

- (id)copyWithZone:(NSZone * _Nullable)zone {
    return self;
}

#pragma mark - Public Method
- (void)bindTarget:(id)target observer:(id)observer keyPath:(NSString *)keyPath {
    if(!target) {
        return;
    }
    
    if(!observer) {
        return;
    }
    
    if(!keyPath.length) {
        return;
    }
    
    NSMapTable<NSString *, NSNumber *> *keyPathMapTable = [[self.KVOMapTable AKStability_observersForTarget:target] AKStability_keyPathsForObserver:observer];
    NSUInteger observeTimes = [[keyPathMapTable objectForKey:keyPath] unsignedLongValue];
    observeTimes++;
    [keyPathMapTable setObject:@(observeTimes) forKey:keyPath];
}

- (void)unbindTarget:(id)target observer:(id)observer keyPath:(NSString *)keyPath {
    if(!target) {
        return;
    }
    
    if(!observer) {
        return;
    }
    
    if(!keyPath.length) {
        return;
    }
    
    NSMapTable<id, NSMapTable<NSString *, NSNumber *> *> *observerMapTable = [self.KVOMapTable AKStability_observersForTarget:target];
    NSMapTable<NSString *, NSNumber *> *keyPathMapTable = [observerMapTable AKStability_keyPathsForObserver:observer];
    NSUInteger observeTimes = [[keyPathMapTable objectForKey:keyPath] unsignedLongValue];
    observeTimes--;
    if(!observeTimes) {
        [keyPathMapTable removeObjectForKey:keyPath];
        if(!keyPathMapTable.count) {
            [observerMapTable removeObjectForKey:observer];
            if(!observerMapTable.count) {
                [self.KVOMapTable removeObjectForKey:target];
                return;
            }
            return;
        }
        return;
    }
    [keyPathMapTable setObject:@(observeTimes) forKey:keyPath];
}

- (NSString *)kvoRelations {
    return self.KVOMapTable.description;
}

@end
