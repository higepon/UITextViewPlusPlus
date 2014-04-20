//
// Created by Taro Minowa on 4/20/14.
// Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

@class UITextViewPlusPlus;

@protocol UITextViewPlusPlusDelegate <NSObject>
@optional
- (void)tappedUrl:(UITextViewPlusPlus *)view url:(NSURL *)url;
@end


@interface UITextViewPlusPlus : UITextView

@property id<UITextViewPlusPlusDelegate, UITextViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer;

- (void)sizeToFitContent;
- (CGFloat)heightForText:(NSAttributedString *)text;

@end