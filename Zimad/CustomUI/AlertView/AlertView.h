//
//  AlertView.h
//  Zimad
//
//  Created by Andrey on 10/31/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    present = 1,
    dismiss = 0
}AlertType;

@protocol AlertViewDelegate <NSObject>

- (void)animationHandler:(AlertType)type;

@end

@interface AlertView : UIView

@property (weak, nonatomic) id<AlertViewDelegate> delegate;

- (void)configureWithTitle:(NSString *)title description:(NSString *)description;

- (void)setAnimationAletWith:(AlertType)type;

@end

