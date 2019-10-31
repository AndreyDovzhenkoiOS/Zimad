//
//  AlertView.m
//  Zimad
//
//  Created by Andrey on 10/31/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;

@end


@implementation AlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    _alertButton.layer.cornerRadius = _alertButton.frame.size.height / 2;
}

- (void)configureWithTitle:(NSString *)title description:(NSString *)description {
    _titleLabel.text = title;
    _descriptionLabel.text = description;
}

- (void)setAnimationAletWith:(AlertType)type {
    switch (type) {
        case present:
            [self animateIn];
            break;
        case dismiss:
            [self animateOut];
            break;
    }
}
- (void)animateIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;

    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
        [self.delegate animationHandler:(present)];
    }];
}

- (void)animateOut {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [self.delegate animationHandler:(dismiss)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)alertAction:(id)sender {
    [self setAnimationAletWith:dismiss];
}


@end
