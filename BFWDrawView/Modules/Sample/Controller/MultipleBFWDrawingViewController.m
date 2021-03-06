//
//  MultipleBFWDrawingViewController.m
//  BFWDrawView
//
//  Created by echen on 26/08/2015.
//  Copyright (c) 2015 BareFeetWare. All rights reserved.
//

#import "MultipleBFWDrawingViewController.h"
#import "BFWDrawView.h"

@interface MultipleBFWDrawingViewController ()
@property (nonatomic, weak) IBOutlet UITextField *loadCountTextField;
@property (nonatomic, weak) IBOutlet UILabel *loadTimeLabel;
@end

@implementation MultipleBFWDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadImages:(id)sender
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[BFWDrawView class]]) {
            [subView removeFromSuperview];
        }
    }
    NSInteger count = self.loadCountTextField.text.integerValue;
    [self.view setNeedsDisplay];
    [CATransaction flush];// force it to render
    
    NSTimeInterval startTime = CACurrentMediaTime();
    for (NSInteger i = 0; i < count; i++) {
        BFWDrawView *featureIcon = [[BFWDrawView alloc] init];
        featureIcon.contentMode = UIViewContentModeCenter;
        featureIcon.name = @"Bathroom";
        featureIcon.styleKit = @"SampleStyleKit";
        //obtain image size from plist
        featureIcon.frame = CGRectMake(0, 0, 224, 164);
        featureIcon.center = self.view.center;
        [self.view addSubview:featureIcon];
    }
    [self.view setNeedsDisplay];
    [CATransaction flush];// force it to render
    
    //work out load time
    NSTimeInterval endTime = CACurrentMediaTime();
    self.loadTimeLabel.text = [NSString stringWithFormat:@"load time : %@", @(endTime - startTime)];
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
