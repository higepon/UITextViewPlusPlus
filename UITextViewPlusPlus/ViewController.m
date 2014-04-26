//
//  ViewController.m
//  UITextViewPlus
//
//  Created by Taro Minowa on 4/19/14.
//  Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

#import "ViewController.h"
#import "UITextViewPlusPlus.h"

@interface ViewController () <UITextViewPlusPlusDelegate>

@end

@implementation ViewController {
    UITextViewPlusPlus *_textViewPlus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _textViewPlus = [[UITextViewPlusPlus alloc] initWithFrame:CGRectMake(5, 200, 280, 200)];
    _textViewPlus.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    _textViewPlus.urlDelegate = self;
    [self.view addSubview:_textViewPlus];
    _textViewPlus.attributedText = [[NSAttributedString alloc] initWithString:@"This is super cool. http://twitter.com/ and this is also good http://facebook.com/ hehe Yahooooooopo"];
}

- (void)tappedUrl:(UITextViewPlusPlus *)view url:(NSURL *)url
{
    NSLog(@"protocol url=%@", url);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
