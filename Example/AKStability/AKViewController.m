//
//  AKViewController.m
//  AKStability
//
//  Created by Freud on 09/08/2016.
//  Copyright (c) 2016 Freud. All rights reserved.
//

#import "AKViewController.h"
#import "A.h"
#import "B.h"
#import "NSObject+AKStability.h"
#import "AKStabilityKVOProtector.h"

@interface AKViewController () {
    A *a;
}

@end

@implementation AKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    A *a = [A new];
    B *b = [B new];
    [b addObserver:a forKeyPath:@"x" options:NSKeyValueObservingOptionNew context:nil];
    NSString *s = [AKStabilityKVOProtector.protector kvoRelations];
    [b AKStability_removeAllObservers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
