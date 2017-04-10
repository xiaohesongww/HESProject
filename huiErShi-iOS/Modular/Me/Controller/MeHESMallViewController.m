//
//  MeHESMallViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeHESMallViewController.h"

@interface MeHESMallViewController ()

@end

@implementation MeHESMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"惠尔仕商城";
    
    UIWebView *hesMallWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    hesMallWebView.backgroundColor = [UIColor yellowColor];
    NSURL *hesURL = [NSURL URLWithString:@"http://www.jd.com"];
    NSURLRequest *hesURLRequest = [NSURLRequest requestWithURL:hesURL];
    [hesMallWebView loadRequest:hesURLRequest];
    [self.view addSubview:hesMallWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
