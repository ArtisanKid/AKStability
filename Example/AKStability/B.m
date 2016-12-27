//
//  B.m
//  AKStability
//
//  Created by 李翔宇 on 2016/12/24.
//  Copyright © 2016年 Freud. All rights reserved.
//

#import "B.h"

@implementation B

- (void)dealloc {
    NSLog(@"B dealloc");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

@end
