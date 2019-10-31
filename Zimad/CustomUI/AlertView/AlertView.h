//
//  AlertView.h
//  Zimad
//
//  Created by Andrey on 10/31/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>

- (void)onTapAlertButton;

@end

@interface AlertView : UIView

@property (weak, nonatomic) id<AlertViewDelegate> delegate;

- (void)configureWithTitle:(NSString *)title description:(NSString *)description;

@end

