//
//  A.m
//  AKStability
//
//  Created by 李翔宇 on 2016/12/24.
//  Copyright © 2016年 Freud. All rights reserved.
//

#import "A.h"

@implementation A

- (void)dealloc {
    NSLog(@"A dealloc");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

@end
