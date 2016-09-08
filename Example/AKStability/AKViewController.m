//
//  AKViewController.m
//  AKStability
//
//  Created by Freud on 09/08/2016.
//  Copyright (c) 2016 Freud. All rights reserved.
//

#import "AKViewController.h"
#import <AKStability/AKStabilityMacro.h>

@interface AKViewController ()

@end

@implementation AKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self testFunc];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AK_Exit
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)testFunc {
    AK_Try_Catch_Finally(({int i = 0;}), ({int i = 0;}), ({int i = 0;}))
    AK_Try_Catch(({int i = 0;}), ({int i = 0;}))
    
    
    NSString *test = nil;
    AK_Nil_Class_Return(test, YES, NSString, 
                        ({int i = 0; NSArray *arr = @[@"0", @"1"];}), nil)
    
    return nil;
}

@end
