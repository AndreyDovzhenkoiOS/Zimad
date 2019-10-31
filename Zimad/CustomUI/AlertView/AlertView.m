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

- (IBAction)alertAction:(id)sender {
    [_delegate onTapAlertButton];
}


@end
