//
//  FontAnimationViewController.m
//  BFWDrawView
//
//  Created by echen on 26/08/2015.
//  Copyright (c) 2015 BareFeetWare. All rights reserved.
//

#import "FontAnimationViewController.h"
#import "FontAnimationView.h"

@interface FontAnimationViewController ()
@property (nonatomic, weak) IBOutlet FontAnimationView *animateView;
@end

@implementation FontAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.animateView animateText:@"Can Pain-t Code do this?"];
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
