//
//  CommonViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "CommonViewController.h"
#import "Define.h"
#import "DiyManager.h"
#import "TipView.h"

@interface CommonViewController ()

@property (nonatomic)UIButton *cancelButton;

@property (nonatomic)UIButton *sendButton;

@property (nonatomic)UITextView *textView;
@property (nonatomic)UILabel *titleLabel;
@property (nonatomic,strong) UILabel *placeholderLabel;

@property (nonatomic)TipView *tipView;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [self.textView becomeFirstResponder];
   }

- (void)createUI{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,kScreenWidth , 40)];
    [self.view addSubview:headView];
    //headView.backgroundColor = [UIColor orangeColor];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(20,0, 40, 40);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
   // _cancelButton.backgroundColor = [UIColor redColor];
    [headView addSubview:_cancelButton];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(kScreenWidth-60, 0, 40, 40);
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _sendButton.enabled=NO;
    [headView addSubview:_sendButton];
    //_sendButton.backgroundColor = [UIColor redColor];
    [_sendButton addTarget:self action:@selector(onSend) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2,0, 100, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //_titleLabel.center = headView.center;
    _titleLabel.text = @"写评论";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_titleLabel];
    //_titleLabel.backgroundColor = [UIColor greenColor];
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60)];
    [self setTextViewPlaceholder:@"写评论..."];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor = [UIColor blackColor];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onTextViewTextChanged) name:UITextViewTextDidChangeNotification object:nil];

    self.tipView = [TipView tipViewWithTitle:@"评论失败"];
    self.tipView.center = self.view.center;
    
    [self.view addSubview:_textView];
    
}

//设置textView的占位符
- (void)setTextViewPlaceholder:(NSString *)placeholder{

    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _placeholderLabel.text = placeholder;
    _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    _placeholderLabel.textColor  = [UIColor grayColor];
    _placeholderLabel.font = [UIFont systemFontOfSize:14];
    [self.textView addSubview:_placeholderLabel];
    //_placeholderLabel.backgroundColor = [UIColor purpleColor];
}

//取消占位符
- (void)hiddenTextViewPlaceholder{
    _textView.text = @"";
    _textView.textColor = [UIColor blackColor];

}

//取消按钮
- (void)onCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.textView resignFirstResponder];
  
}

//发送
- (void)onSend{
    
    self.sendButton.enabled=NO;
    [self.textView resignFirstResponder];
   // [self.delegate showToorbar];
    NSString *url = [NSString stringWithFormat:KDiyCommonUrl,self.theId];
    [DiyManager sentCommonWithUrl:url content:self.textView.text success:^{
        [self dismissViewControllerAnimated:YES completion:^{
           //  NSLog(@"success");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"send" object:nil];
           
        }];
       // NSLog(@"success");
    } failure:^{
        NSLog(@"hhhhhhhhhhhhhh");
        
        [self.view bringSubviewToFront:self.tipView];
        [self.tipView showTipView];
    }];
}

//监听textview文本框有内容
- (void)onTextViewTextChanged{
    
// [self hiddenTextViewPlaceholder];
    self.placeholderLabel.hidden = YES;
    if (![self.textView.text isEqualToString:@""]) {
        self.sendButton.enabled = YES;
    }else{
        self.sendButton.enabled = NO;
        self.placeholderLabel.hidden=NO;
    }
    
}

//移除观察者
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
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
