## What is this?
This is UITextView with
- Tappable URLs
- Automatically resize hight
- Roundded corner and right paddings

![screenshot](https://raw.githubusercontent.com/higepon/UITextViewPlusPlus/master/screen.png)
## How To Install
Copy UITextViewPlusPlus.h and .m to your project.

## How to Use
In your UIViewController
````objc
#import "UITextViewPlusPlus.h"
...

_textViewPlus = [[UITextViewPlusPlus alloc] initWithFrame:CGRectMake(5, 200, 280, 200)];
_textViewPlus.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
_textViewPlus.urlDelegate = self;
[self.view addSubview:_textViewPlus];
_textViewPlus.text = @"This is super cool. http://twitter.com/ and this is also good http://facebook.com/ hehe Yahooooooopo";

````

If you want to handle URL tapped event.
````objc
@interface ViewController () <UITextViewPlusPlusDelegate>
...
- (void)tappedUrl:(UITextViewPlusPlus *)view url:(NSURL *)url
{
    NSLog(@"protocol url=%@", url);
}
````
