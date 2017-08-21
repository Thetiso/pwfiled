//
//  LoginViewController.m
//  PetAdopt
//
//  Created by Matthew on 2017/8/17.
//  Copyright © 2017年 Matthew. All rights reserved.
//

#import "ViewController.h"
#import "Mcommon.h"
@interface ViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property(nonatomic, strong) UIImageView * bgImgview;
@property(nonatomic, strong) UILabel * projectName;
@property(nonatomic, strong) UILabel * subTitle;
@property(nonatomic, strong) UITextField * phoneField;
@property(nonatomic, strong) UILabel * notice;  //验证码已发送/次数到达上限
@property(nonatomic, strong) UIView * codeView;
@property(nonatomic, strong) UITextField * codeField;
@property(nonatomic, strong) UITextView * agreement;
@end

@implementation ViewController
{
    MCommon * com_;
    CGFloat nameHeight_;
    CGFloat subtitleHeight_;
    CGFloat phoneFieldHeight_;
    CGFloat codeFieldHeight_;
    CGFloat agreementHeight_;
    CGFloat keybroadHeight_;
    CGFloat contentWidth_;
    CGFloat margin_;
    CGFloat codeCellWidth_;
    
    NSString * phoneNum_;
    NSMutableArray * codeFieldArray_;
}
-(instancetype)init
{
    if (self = [super init]) {
        com_ = [MCommon share];
        keybroadHeight_ = com_.Height > 700 ? 226 : 216;
        CGFloat viladHeight = com_.Height - keybroadHeight_ - STATUSHEIGHT;
        nameHeight_ = subtitleHeight_ = viladHeight * 0.2;
        phoneFieldHeight_ = codeFieldHeight_ = viladHeight * 0.3;
        agreementHeight_ = viladHeight * 0.1;
        margin_ = 2 * NORMALMARGINLEFTANDRIGHT;
        contentWidth_ = com_.Width - 2 * margin_;
        codeCellWidth_ = 60;
        codeFieldArray_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareSubviews];
}
-(void)prepareSubviews
{
    [self.view addSubview:self.bgImgview];
    [self.view addSubview:self.projectName];
    [self.view addSubview:self.subTitle];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.agreement];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.phoneField canBecomeFirstResponder]) {
        [self.phoneField becomeFirstResponder];
    }
}

#pragma mark - property
-(UILabel *)projectName
{
    if (!_projectName) {
        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(margin_, STATUSHEIGHT, contentWidth_, nameHeight_)];
        _projectName.text = @"ProjectName";
        _projectName.textColor = [UIColor darkBlack];
        _projectName.font = [UIFont kfont24];
    }
    return _projectName;
}
-(UILabel *)subTitle
{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(margin_, CGRectGetMaxY(self.projectName.frame), contentWidth_, subtitleHeight_)];
        _subTitle.text = @"欢迎回来";
        _subTitle.textColor = [UIColor lightBlack];
        _subTitle.font = [UIFont bfont30];
    }
    return _subTitle;
}
-(UITextField *)phoneField
{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(margin_, CGRectGetMaxY(self.subTitle.frame), contentWidth_, phoneFieldHeight_)];
        _phoneField.delegate = self;
        _phoneField.placeholder = @"输入手机号注册/登录";
        _phoneField.font = [UIFont kfont24];
        _phoneField.textColor = [UIColor grayText];
        _phoneField.tintColor = [UIColor grayText];
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField addTarget:self action:@selector(phoneValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
        CGFloat layerHeight = 2;
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, phoneFieldHeight_ / 2 + 12 + 5, contentWidth_, layerHeight);
        layer.cornerRadius = layerHeight / 2;
        layer.backgroundColor = [UIColor grayBg].CGColor;
        [_phoneField.layer addSublayer:layer];
    }
    return _phoneField;
}
-(void)phoneValueChanged:(UITextField *)textField
{
    if (textField.text && textField.text.length == 11) {
        phoneNum_ = textField.text;
        if ([self validateMobile:textField.text]) {
            [self sendSMS];
        } else if ([textField.text isEqualToString:@"21234567890"]) {
            [self showCodeTextField];
        }
    }
}
-(UILabel *)notice
{
    if (!_notice) {
        _notice = [[UILabel alloc] initWithFrame:CGRectMake(margin_, CGRectGetMaxY(self.subTitle.frame), contentWidth_, phoneFieldHeight_)];
        _notice.textColor = [UIColor grayText];
        _notice.font = com_.Width > 400 ?  [UIFont kfont20] : [UIFont kfont17];
        _notice.alpha = 0;
    }
    return _notice;
}
-(UIView *)codeView
{
    if (!_codeView) {
        _codeView = [[UIView alloc] initWithFrame:CGRectMake(margin_, CGRectGetMaxY(self.phoneField.frame), contentWidth_, codeCellWidth_)];
        CGFloat cellMargin = (contentWidth_ - codeCellWidth_ * 4) / 3;
        for (int i = 0; i < 4; i ++) {
            UITextField * tmpField = [[UITextField alloc] initWithFrame:CGRectMake((cellMargin + codeCellWidth_ ) * i, 0, codeCellWidth_, codeCellWidth_)];
            tmpField.layer.cornerRadius = NORMALTABLECELLMARGINBOTTOM;
            tmpField.layer.masksToBounds = YES;
            tmpField.backgroundColor = [[UIColor grayBg] colorWithAlphaComponent:0.5];
            tmpField.font = [UIFont bfont30];
            tmpField.textAlignment = NSTextAlignmentCenter;
            tmpField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            tmpField.textColor = [UIColor blueText];
            tmpField.delegate  = self;
            tmpField.tintColor = [UIColor grayText];
            //            tmpField.text = @"";
            tmpField.placeholder = @" ";
            tmpField.keyboardType = UIKeyboardTypeNumberPad;
            tmpField.enabled = NO;
            [tmpField addTarget:self action:@selector(codeInput:) forControlEvents:UIControlEventEditingChanged];
            [codeFieldArray_ addObject:tmpField];
            [_codeView addSubview:tmpField];
        }
    }
    return _codeView;
}
-(void)enableEditCodeAtIndex:(NSUInteger)idx
{
    if (idx == NSNotFound || idx >= codeFieldArray_.count) {
        return;
    }
    [codeFieldArray_ enumerateObjectsUsingBlock:^(UITextField  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = NO;
    }];
    UITextField * tmp = (UITextField *)codeFieldArray_[idx];
    [tmp setEnabled:YES];
    if ([tmp canBecomeFirstResponder]) {
        [tmp becomeFirstResponder];
    }
    
}
-(UITextField *)codeField
{
    if (!_codeField) {
        _codeField = [[UITextField alloc] initWithFrame:CGRectMake(margin_, CGRectGetMaxY(self.phoneField.frame), codeCellWidth_, codeCellWidth_)];
        _codeField.layer.cornerRadius = NORMALTABLECELLMARGINBOTTOM;
        _codeField.layer.masksToBounds = YES;
        _codeField.backgroundColor = [[UIColor grayBg] colorWithAlphaComponent:0.5];
        _codeField.font = [UIFont bfont30];
        _codeField.textAlignment = NSTextAlignmentCenter;
        _codeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _codeField.textColor = [UIColor blueText];
        _codeField.delegate  = self;
        _codeField.tintColor = [UIColor grayText];
        _codeField.placeholder = @" "; //配合leftview 让光标居中！！！
        //        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        //        _codeField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        //        _codeField.leftView.userInteractionEnabled = NO;
        //        _codeField.leftViewMode = UITextFieldViewModeAlways;
        //有内容的时候把leftview置空！！！
    }
    return _codeField;
}
-(UIImageView *)bgImgview
{
    if (!_bgImgview) {
        _bgImgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, com_.Width, com_.Height)];
        _bgImgview.image = [UIImage imageNamed:@"login_bg"];
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, com_.Width, com_.Height);
        effectView.alpha = 0.8;
        [_bgImgview addSubview:effectView];
    }
    return _bgImgview;
}

-(UITextView *)agreement
{
    if (!_agreement) {
        _agreement = [[UITextView alloc] initWithFrame:CGRectMake(margin_, com_.Height - keybroadHeight_ - agreementHeight_, contentWidth_, agreementHeight_)];
        _agreement.font = [UIFont kfont13];
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"验证通过即表示你已阅读并同意《用户使用协议》"];
        [attrStr addAttribute:NSLinkAttributeName
                        value:@"http://agreement"
                        range:NSMakeRange(attrStr.length - 8, 8)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]
                        range:NSMakeRange(attrStr.length - 8, 8)];
        _agreement.attributedText = attrStr;
        _agreement.delegate = self;
        _agreement.editable = NO;
        _agreement.backgroundColor = [UIColor clearColor];
        _agreement.tintColor = [UIColor redColor];
    }
    return _agreement;
}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (![textField isEqual:_phoneField]) {
        if (!textField.text.length) {
            textField.text = @"";
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
            textField.leftView.userInteractionEnabled = NO;
            textField.leftViewMode = UITextFieldViewModeAlways;
        }
    }
    return YES;
}
-(void)codeInput:(UITextField *)textField
{
    if (textField.text.length) {
        textField.leftView = nil;
        if ([textField canResignFirstResponder]) {
            [textField resignFirstResponder];
        }
        textField.enabled = NO;
        __block NSInteger curIndex = 0;
        __block NSInteger nextIndex = 100;
        [codeFieldArray_ enumerateObjectsUsingBlock:^(UITextField *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:textField]) {
                curIndex = idx;
            }
            if ((obj.text.length == NSNotFound || !obj.text.length) && idx < nextIndex) {
                nextIndex = idx;
            }
        }];
        if (nextIndex < codeFieldArray_.count) {
            [self enableEditCodeAtIndex:nextIndex];
        } else {
            [self checkCodes];
        }
    } else {
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        textField.leftView.userInteractionEnabled = NO;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
}
#pragma  mark - textview delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return NO;
}

#pragma mark - helper

-(void)sendSMS
{
    //假设发送成功
    [self showCodeTextField];
}
-(void)checkCodes
{
    
}
-(void)showCodeTextField
{
    //手机号码输入框上移并消失，显示notice框
    [self.view addSubview:self.notice];
    _notice.text = [NSString stringWithFormat:@"验证码送达 %@ (60s)",phoneNum_];
    [UIView animateWithDuration:0.4 animations:^{
        _phoneField.center = CGPointMake(com_.Width + _phoneField.center.x, _phoneField.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _notice.alpha = 1;
            //            [self.view addSubview:self.codeField];
            [self.view addSubview:self.codeView];
            [self enableEditCodeAtIndex:0];
        }];
    }];
}
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|70|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189,177
     22         */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
