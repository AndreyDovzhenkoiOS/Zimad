//
//  CircleView.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSSARefreshCircleViewHeight 40

@interface CircleView : UIView

@property (nonatomic, assign) CGFloat heightBeginToRefresh;

@property (nonatomic, assign) CGFloat offsetY;

@end
