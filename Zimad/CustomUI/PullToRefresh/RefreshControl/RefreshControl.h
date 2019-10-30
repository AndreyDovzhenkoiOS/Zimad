//
//  RefreshControl.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"

typedef NS_ENUM(NSInteger, SSARefreshViewLayerType) {
    SSARefreshViewLayerTypeOnSuperView = 0,
    SSARefreshViewLayerTypeOnScrollView = 1,
};


@protocol SSARefreshControlDelegate <NSObject>

@required

- (void)beganRefreshing;

@end

@interface RefreshControl : NSObject

@property (weak, nonatomic) id <SSARefreshControlDelegate> delegate;

- (id)initWithScrollView:(UIScrollView *)scrollView andRefreshViewLayerType:(SSARefreshViewLayerType)refreshViewLayerType;

- (void)beginRefreshing;

- (void)endRefreshing;

@end

@interface RefreshCircleContainerView : UIView

@property (strong, nonatomic) CircleView *circleView;

@end

