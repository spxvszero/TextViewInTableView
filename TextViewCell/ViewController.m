//
//  ViewController.m
//  TextViewCell
//
//  Created by jacky on 16/2/16.
//  Copyright © 2016年 com.jacky.cc. All rights reserved.
//

#import "ViewController.h"
#import "TextTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    textView.layer.borderColor = [UIColor blackColor].CGColor;
//    textView.layer.borderWidth = 2;
//    textView.scrollEnabled = NO;
//    [self.view addSubview:textView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[[TextTableViewController alloc] init] animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
