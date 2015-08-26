//
//  PacManView.m
//  BFWDrawView
//
//  Created by echen on 18/08/2015.
//  Copyright (c) 2015 BareFeetWare. All rights reserved.
//

#import "PacManView.h"

@interface PacManView ()
@property (nonatomic) CAShapeLayer *pacManLayer;
@end
@implementation PacManView


- (void)startAnimate {
	self.pacManLayer = [CAShapeLayer layer];
	UIColor *color = [UIColor colorWithRed:1 green:0.806 blue:0 alpha:1];
	CGFloat lineWidth = 0;

	CGFloat radius = CGRectGetWidth(self.bounds) / 2;
	//CGRect rect = CGRectMake(lineWidth / 2 + lineWidth, lineWidth / 2 + lineWidth, radius * 2, radius * 2);
	CGFloat bottomLip = 15.0;
	UIBezierPath *fromPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:bottomLip * M_PI / 180 endAngle:-bottomLip * M_PI / 180 clockwise:YES];
	[fromPath addLineToPoint:CGPointMake(radius, radius)];
	UIBezierPath *toPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 * M_PI / 180 endAngle:360 * M_PI / 180 clockwise:YES];
	[toPath addLineToPoint:CGPointMake(radius, radius)];
	self.pacManLayer.path = fromPath.CGPath;
	self.pacManLayer.strokeColor = color.CGColor;
	self.pacManLayer.fillColor = color.CGColor;
	self.pacManLayer.lineWidth = lineWidth;
	self.pacManLayer.lineCap = kCALineCapRound;
	self.pacManLayer.lineJoin = kCALineJoinRound;
	self.pacManLayer.frame = self.bounds;
	[self.layer addSublayer:self.pacManLayer];

	CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
	pathAnimation.duration = 0.5;
	// The path property has not been updated to the new value yet
	pathAnimation.fromValue = (id)fromPath.CGPath;
	// Compute the new value for path
	pathAnimation.toValue = (id)toPath.CGPath;
	pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; // animation curve is Ease Out
	pathAnimation.fillMode = kCAFillModeBoth; // keep to value after finishing
	pathAnimation.removedOnCompletion = NO; // don't remove after finishing
	pathAnimation.autoreverses = YES;
	pathAnimation.repeatCount = CGFLOAT_MAX;

	[self.pacManLayer addAnimation:pathAnimation forKey:@"path"];
}


@end
