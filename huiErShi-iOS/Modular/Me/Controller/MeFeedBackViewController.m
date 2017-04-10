//
//  MeFeedBackViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeFeedBackViewController.h"

@interface MeFeedBackViewController () <UITextViewDelegate>
@property (nullable, nonatomic, strong) UITextView *feedBackTextView;
@property (nullable, nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation MeFeedBackViewController

#pragma mark -- 提交反馈网络请求
- (void)sendFeedBackRequest {
    NSDictionary *dict = @{
                           @"userId":USER_ID,
                           @"content":self.feedBackTextView.text,
                           };
    NSString *urlString = [TEST_URL stringByAppendingString:@"feedback"];
    [[NetworkEngine sharedNetworkEngine] postWithURLString:urlString parameters:dict success:^(id responseObject) {
        [self showTitle:@"提交成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"反馈";
    
    [self setupUI];
}

- (void)setupUI {
    UITextView *feedBackTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, LayOutH(20), kScreenWidth, LayOutH(352))];
    feedBackTextView.backgroundColor = [UIColor whiteColor];
    feedBackTextView.delegate = self;
    feedBackTextView.font = [UIFont systemFontOfSize:18];
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text = @"期待您的反馈，不超过200字。";
    placeholderLabel.textColor = HESCOLOR(153, 153, 153);
    self.placeholderLabel = placeholderLabel;
    [feedBackTextView addSubview:placeholderLabel];
    
    self.feedBackTextView = feedBackTextView;
    [self.view addSubview:feedBackTextView];
    
    placeholderLabel.sd_layout.leftSpaceToView(feedBackTextView,LayOutW(20)).topSpaceToView(feedBackTextView,LayOutH(30)).heightIs(LayOutH(44)).widthIs(LayOutW(525));
    
    UIButton *feedBackButton = [[UIButton alloc] init];
    [feedBackButton setTitle:@"提交" forState:UIControlStateNormal];
    feedBackButton.backgroundColor = HESCOLOR(250, 124, 11);
    [self.view addSubview:feedBackButton];
    feedBackButton.sd_layout.topSpaceToView(feedBackTextView, LayOutH(40)).heightIs(LayOutH(80)).widthIs(LayOutW(600)).centerXEqualToView(self.view);
    [feedBackButton addTarget:self action:@selector(feedBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
    }
}

- (void)feedBackButtonPressed {
    // 检测文字长度
    if ([self checkLength]) {
        [self sendFeedBackRequest];
    }
}
//检测文字长度
- (BOOL)checkLength {
    if (self.feedBackTextView.text.length > 200) {
        [self showTitle:@"反馈的字数不能超过200个字"];
        return NO;
    } else if (self.feedBackTextView.text.length == 0) {
        [self showTitle:@"请您输入反馈文字"];
        return NO;
    } else {
        return YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.feedBackTextView resignFirstResponder];
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
