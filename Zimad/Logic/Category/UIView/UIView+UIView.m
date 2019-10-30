//
//  UIView+UIView.m
//  Zimad
//
//  Created by Andrey on 10/25/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "UIView+UIView.h"

@implementation UIView (UIView)

- (void)setupShadow:(CGFloat)radius opacity:(CGFloat)opacity height:(CGFloat)height {
    self.layer.shouldRasterize = YES;
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = CGSizeMake(0, height);
    self.layer.shadowOpacity = radius;
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
}

@end
