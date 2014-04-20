//
// Created by Taro Minowa on 4/20/14.
// Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

#import "UITextViewPlusPlus.h"

@implementation UITextViewPlusPlus {
    NSMutableArray *_rangeAndUrls;
}

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        // top, left, bottom, right
        self.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.layer.cornerRadius = 3.0f;
        self.clipsToBounds = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)sizeToFitContent
{
    CGSize size = [self sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGFloat)heightForText:(NSAttributedString *)text
{
    UITextViewPlusPlus *view = [[UITextViewPlusPlus alloc] initWithFrame:self.frame];
    view.attributedText = text;
    return view.frame.size.height;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    NSMutableAttributedString *text = [attributedText mutableCopy];
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:attributedText.string options:0 range:NSMakeRange(0, [attributedText.string length])];
    _rangeAndUrls = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            NSRange range = [match range];
            [_rangeAndUrls addObject:@[[NSValue valueWithRange:range], url]];
            [text setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}
                                    range:range];
        }
    }
    [super setAttributedText:text];
    [self sizeToFitContent];
}

- (void)textTapped:(UITapGestureRecognizer *)recognizer
{
    if (![self.delegate respondsToSelector:@selector(tappedUrl:url:)]) {
        return;
    }

    UITextView *textView = (UITextView *)recognizer.view;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;
    NSUInteger characterIndex = [textView.layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];

    if (characterIndex < textView.textStorage.length) {
        for (NSArray* rangeAndUrl in _rangeAndUrls) {
            NSRange range = [rangeAndUrl[0] rangeValue];
            if (NSLocationInRange(characterIndex, range)) {
                [self.delegate tappedUrl:self url:rangeAndUrl[1]];
                return;
            }
        }
    }
}

@end