//
//  PullToRefreshAnimator.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef CGFloat (*ViewEasingFunctionPointerType)(CGFloat);

@interface PullToRefreshAnimator : NSObject

+ (CABasicAnimation *)repeatRotateAnimation;

+ (CAKeyframeAnimation *)popAnimation;

+ (CAKeyframeAnimation *) animationWithCATransform3DForKeyPath:(NSString *)keyPath
                                                easingFunction:(ViewEasingFunctionPointerType)function
                                                    fromMatrix:(CATransform3D)fromMatrix
                                                      toMatrix:(CATransform3D)toMatrix;

@end

CGFloat SSAElasticEaseIn(CGFloat p);


