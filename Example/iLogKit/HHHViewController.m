//
//  HHHViewController.m
//  iLogKit_Example
//
//  Created by 洪利 on 2020/8/6.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "HHHViewController.h"
#import "iLogKit-Swift.h"
@interface HHHViewController ()

@end

@implementation HHHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ILogObjc writeWithLevel:4 label:@"hahahha"];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
