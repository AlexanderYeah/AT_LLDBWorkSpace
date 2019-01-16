//
//  ViewController.m
//  SK_LLDB1
//
//  Created by TrimbleZhang on 2019/1/16.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"alex",@"apple",@"bounce",@"age"];
    
    
    NSString * a = arr[1];
    NSString * b = arr[1];
    NSString * c = arr[1];
    NSString * d = arr[1];
    
    NSLog(@"%@",a);
    NSLog(@"%@",b);
    NSLog(@"%@",c);
    NSLog(@"%@",d);
    
    
    
}

- (IBAction)add:(id)sender {
    
    NSLog(@"点击了按钮");
    NSArray *arr = @[@"alex",@"apple",@"bounce",@"age"];
    
    
    NSString * a = arr[5];

    NSLog(@"%@",a);
}

@end
