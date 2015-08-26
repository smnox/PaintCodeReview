//
//  ViewController.m
//  BFWDrawView
//
//  Created by echen on 18/08/2015.
//  Copyright (c) 2015 BareFeetWare. All rights reserved.
//

#import "PacManViewController.h"
#import "PacManView.h"

@interface PacManViewController ()
@property (nonatomic, weak) IBOutlet PacManView *animateView;
@end

@implementation PacManViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    [self.animateView startAnimate];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
