//
//  RefreshControl.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "RefreshControl.h"
#import "PullToRefreshAnimator.h"

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

#define kSSADefaultRefreshTotalPixels 60

typedef NS_ENUM(NSInteger, SSARefreshState) {
    SSARefreshStatePulling = 0,
    SSARefreshStateNormal = 1,
    SSARefreshStateLoading = 2,
    SSARefreshStateStopped = 3,
};

@interface RefreshControl ()

@property (readwrite, nonatomic) CGFloat originalTopInset;
@property (assign, nonatomic) CGFloat refreshTotalPixels;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) RefreshCircleContainerView *refreshCircleContainerView;
@property (assign, nonatomic) SSARefreshState refreshState;
@property (assign, nonatomic) SSARefreshViewLayerType refreshViewLayerType;
@property (assign, nonatomic) BOOL isRefreshing;

@end

@implementation RefreshControl

- (id)initWithScrollView:(UIScrollView *)scrollView andRefreshViewLayerType:(SSARefreshViewLayerType)refreshViewLayerType; {
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        self.refreshViewLayerType = refreshViewLayerType;
        [self setupRefreshControl];
    }
    return self;
}


- (void)beginRefreshing {
    self.isRefreshing = YES;
    self.refreshState = SSARefreshStatePulling;
    self.refreshState = SSARefreshStateLoading;

}

- (void)createCircleViewAnimations {
    
    if (self.refreshCircleContainerView.circleView.offsetY != kSSADefaultRefreshTotalPixels - kSSARefreshCircleViewHeight) {
        self.refreshCircleContainerView.circleView.offsetY = kSSADefaultRefreshTotalPixels - kSSARefreshCircleViewHeight;
    }
    [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
    [self.refreshCircleContainerView.circleView.layer addAnimation:[PullToRefreshAnimator popAnimation] forKey:@"transform"];
    [self.refreshCircleContainerView.circleView.layer addAnimation:[PullToRefreshAnimator repeatRotateAnimation] forKey:@"rotateAnimation"];
    [self beganRefreshing];
}



- (void)beganRefreshing {
    [self setScrollViewContentInset];
    if ([self.delegate respondsToSelector:@selector(beganRefreshing)]) {
        [self.delegate beganRefreshing];
    }
}


- (void)endRefreshing {
    self.isRefreshing = NO;
    self.refreshState = SSARefreshStateStopped;
    [self resetScrollViewContentInset];
}

- (void)resetScrollViewContentInset {
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.top = self.originalTopInset;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.scrollView.contentInset = contentInset;
    } completion:^(BOOL finished) {

        self.refreshState = SSARefreshStateNormal;
        self.refreshCircleContainerView.circleView.offsetY = 0;
        if (self.refreshCircleContainerView.circleView) {
            [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
        }
       self.refreshCircleContainerView.circleView.offsetY = 0;

    }];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:^(BOOL finished) {
                         if (finished && self.refreshState == SSARefreshStateStopped) {
                             self.refreshState = SSARefreshStateNormal;
                             
                             if (self.refreshCircleContainerView.circleView) {
                                 [self.refreshCircleContainerView.circleView.layer removeAllAnimations];
                             }
                         }
                     }];
}

- (void)setScrollViewContentInsetForLoading {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.refreshTotalPixels;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInset {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = 0;
    [self setScrollViewContentInset:currentInsets];
}

- (RefreshCircleContainerView *)refreshCircleContainerView {
    if (!_refreshCircleContainerView) {
        _refreshCircleContainerView = [[RefreshCircleContainerView alloc] initWithFrame:CGRectMake(0, (self.refreshViewLayerType == SSARefreshViewLayerTypeOnScrollView ? -kSSADefaultRefreshTotalPixels : self.originalTopInset), CGRectGetWidth([[UIScreen mainScreen] bounds]), kSSADefaultRefreshTotalPixels)];
        _refreshCircleContainerView.backgroundColor = [UIColor clearColor];
        _refreshCircleContainerView.circleView.heightBeginToRefresh = kSSADefaultRefreshTotalPixels - kSSARefreshCircleViewHeight;
        _refreshCircleContainerView.circleView.offsetY = 10;

     }
    return _refreshCircleContainerView;
}

- (CGFloat)refreshTotalPixels {
    return kSSADefaultRefreshTotalPixels + [self getAdaptorHeight];
}

- (CGFloat)getAdaptorHeight {
    return self.originalTopInset;
}

- (void)setRefreshState:(SSARefreshState)refreshState {
    switch (refreshState) {
        case SSARefreshStateStopped:
        case SSARefreshStateNormal:
        case SSARefreshStateLoading: {
            if (self.isRefreshing) {
       
                [self setScrollViewContentInsetForLoading];
                
                if(_refreshState == SSARefreshStatePulling) {
                    [self createCircleViewAnimations];
                }
            }
            break;
        }
        case SSARefreshStatePulling:
            break;
        default:
            break;
    }
    
    _refreshState = refreshState;

}

- (void)setupRefreshControl {
    
    self.originalTopInset = self.scrollView.contentInset.top;
    
    self.refreshState = SSARefreshStateNormal;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    if (self.refreshViewLayerType == SSARefreshViewLayerTypeOnSuperView) {
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self.scrollView.superview insertSubview:self.refreshCircleContainerView belowSubview:self.scrollView];
        
    } else if (self.refreshViewLayerType == SSARefreshViewLayerTypeOnScrollView) {
        [self.scrollView addSubview:self.refreshCircleContainerView];
    }
}

- (void)dealloc {
   
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    self.scrollView = nil;
    [self.refreshCircleContainerView removeFromSuperview];
    self.refreshCircleContainerView = nil;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        if(self.refreshState != SSARefreshStateLoading) {
            
            CGFloat pullDownOffset = (MIN(ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]), kSSADefaultRefreshTotalPixels) - kSSARefreshCircleViewHeight);
            if (ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]) >= kSSARefreshCircleViewHeight) {
                if (!self.isRefreshing) {
                    self.refreshCircleContainerView.circleView.offsetY = pullDownOffset;
                }
                
            }
            
            CGFloat scrollOffsetThreshold = -(kSSADefaultRefreshTotalPixels + self.originalTopInset);
            
            if(!self.scrollView.isDragging && self.refreshState == SSARefreshStatePulling) {
                if (!self.isRefreshing) {
                    self.isRefreshing = YES;
                    self.refreshState = SSARefreshStateLoading;
                }
            } else if(contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging && self.refreshState == SSARefreshStateStopped) {
                self.refreshState = SSARefreshStatePulling;
            } else if(contentOffset.y >= scrollOffsetThreshold && self.refreshState != SSARefreshStateStopped) {
                self.refreshState = SSARefreshStateStopped;
            }
        } else {
            if (self.isRefreshing) {
                CGFloat offset;
                UIEdgeInsets contentInset;
                offset = MAX(self.scrollView.contentOffset.y * -1, kSSADefaultRefreshTotalPixels);
                offset = MIN(offset, self.refreshTotalPixels);
                contentInset = self.scrollView.contentInset;
                self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
            }
        }
    }
}

@end


@implementation RefreshCircleContainerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.circleView];
        
    }
    return self;
}

- (CircleView *)circleView {
    if (!_circleView) {
        _circleView = [[CircleView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - kSSARefreshCircleViewHeight) / 2, (CGRectGetHeight(self.bounds) - kSSARefreshCircleViewHeight) / 2 - 5, kSSARefreshCircleViewHeight, kSSARefreshCircleViewHeight)];
    }
    return _circleView;
}

- (void)dealloc {
    _circleView = nil;
}

@end
