//
//  ViewController.m
//  UITextViewPlus
//
//  Created by Taro Minowa on 4/19/14.
//  Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

#import "ViewController.h"
#import "UITextViewPlusPlus.h"

/*

- Extract class
- define delegate
- adjust size
- return height
- remove warnings
 */

@interface ViewController () <UITextViewPlusPlusDelegate>

@end

@implementation ViewController {
    UITextView *_textView;
    UITextViewPlusPlus *_textViewPlus;
    NSMutableArray *_urlRanges;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"UIDisableLegacyTextView"];
    self.view.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 50, 280, 200)];
    _textView.backgroundColor = [UIColor grayColor];
    // top, left, bottom, right
    _textView.textContainerInset = UIEdgeInsetsMake(70, 70, 0, 0);
    _textView.layer.cornerRadius = 3.0f;
    _textView.clipsToBounds = YES;

    _urlRanges = [NSMutableArray arrayWithCapacity:0];

    _textViewPlus = [[UITextViewPlusPlus alloc] initWithFrame:CGRectMake(5, 200, 280, 200)];
    _textViewPlus.backgroundColor = [UIColor grayColor];
    _textViewPlus.delegate = self;
    [self.view addSubview:_textViewPlus];
    _textViewPlus.text = @"This is super cool. http://twitter.com/ and this is also good http://facebook.com/ hehe Yahooooooopo";

    NSString *text = @"This is super cool. http://twitter.com/ and this is also good http://facebook.com/ hehe Yahooooooopo";
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    NSMutableArray *urls = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSTextCheckingResult *match in matches) {

        if ([match resultType] == NSTextCheckingTypeLink) {

            NSURL *url = [match URL];
            NSRange range = [match range];
            [_urlRanges addObject:@[[NSValue valueWithRange:range], url]];
//            [urls addObject:url];
            NSRange purpleBoldTextRange = [match range];
            NSLog(@"range=%d", [match range].location);
            [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor], @"Link":@(YES)}
                                    range:purpleBoldTextRange];

        }
    }

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped:)];
    [_textView addGestureRecognizer:tapRecognizer];
    _textView.attributedText = attributedText;
    [self.view addSubview:_textView];


//    _textView.frame = [self contentSizeRectForTextView:_textView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGSize size = [_textView sizeThatFits:CGSizeMake(280, 1000)];

    CGRect frame = _textView.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    _textView.frame = frame;
}


- (CGRect)contentSizeRectForTextView:(UITextView *)textView
{
    [textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
    CGRect textBounds = [textView.layoutManager usedRectForTextContainer:textView.textContainer];
    CGFloat width =  (CGFloat)ceil(textBounds.size.width + textView.textContainerInset.left + textView.textContainerInset.right);
    CGFloat height = (CGFloat)ceil(textBounds.size.height + textView.textContainerInset.top + textView.textContainerInset.bottom);
    return CGRectMake(0, 0, width, height);
}

- (void)textTapped:(UITapGestureRecognizer *)recognizer
{
    UITextView *textView = (UITextView *)recognizer.view;
    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;

    NSLog(@"location: %@", NSStringFromCGPoint(location));

    // Find the character that's been tapped on

    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];

    if (characterIndex < textView.textStorage.length) {

        NSRange range;
        NSDictionary *attributes = [textView.textStorage attributesAtIndex:characterIndex effectiveRange:&range];
        NSLog(@"%@, %@", attributes, NSStringFromRange(range));
        if ([attributes objectForKey:@"Link"]) {
            NSLog(@"Link index=%d", characterIndex);
            for (NSArray* urlRange in _urlRanges) {
                NSRange range = [[urlRange objectAtIndex:0] rangeValue];
                NSLog(@"found in range %d", range.location);
                if (NSLocationInRange(characterIndex, range)) {
                    NSLog(@"Url=%@", urlRange[1]);
                }
            }
        }

        //Based on the attributes, do something
        ///if ([attributes objectForKey:...)] //make a network call, load a cat Pic, etc

    }
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
