//
//  FontAnimationView.m
//  BFWDrawView
//
//  Created by echen on 26/08/2015.
//  Copyright (c) 2015 BareFeetWare. All rights reserved.
//

#import "FontAnimationView.h"
#import <CoreText/CoreText.h>
@implementation FontAnimationView

- (void)animateText:(NSString *) textToAnimate {
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica-Bold"), 48.0f, nil);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:textToAnimate
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGFloat lineWidth = 2;
    UIColor *color = [UIColor blackColor];
    CAShapeLayer *fontLayer = [CAShapeLayer layer];
    fontLayer.path = path.CGPath;
    fontLayer.strokeColor = color.CGColor;
    fontLayer.geometryFlipped = YES;
    fontLayer.fillColor = nil;
    fontLayer.lineWidth = lineWidth;
    fontLayer.lineCap = kCALineCapRound;
    fontLayer.lineJoin = kCALineJoinRound;
    fontLayer.frame = self.bounds;
    fontLayer.strokeEnd = 0;
    [self.layer addSublayer:fontLayer];
    fontLayer.frame = CGRectMake(0, 50, 320, 200);
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5;
    // The path property has not been updated to the new value yet
    pathAnimation.fromValue = @(0);
    // Compute the new value for path
    pathAnimation.toValue = @(1);
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; // animation curve is Ease Out
    pathAnimation.fillMode = kCAFillModeBoth; // keep to value after finishing
    pathAnimation.removedOnCompletion = NO; // don't remove after finishing
    pathAnimation.autoreverses = YES;
    pathAnimation.repeatCount = CGFLOAT_MAX;
    [fontLayer addAnimation:pathAnimation forKey:@"fontStroke"];
    
    CGPathRelease(letters);
    CFRelease(font);
}


@end
