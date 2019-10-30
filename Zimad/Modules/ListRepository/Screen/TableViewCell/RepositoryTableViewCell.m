//
//  RepositoryTableViewCell.m
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "RepositoryTableViewCell.h"

@interface RepositoryTableViewCell()

@property (strong, nonatomic) NetworkService *service;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation RepositoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configurationUI];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _iconImageView.image = [UIImage imageNamed:@"emptyIcon"];
}

- (void)configureWith:(Repository *)repository service:(NetworkService*)service {
    _service = service;
    _titleLabel.text = repository.title;
    _nameLabel.text = repository.fullName;
    _descriptionLabel.text = repository.descriptions;
    [_service getImageWithUrl:[NSURL URLWithString: repository.avatarUrl] completion:^(UIImage *image) {
        self.iconImageView.image = image;
    }];
}

- (void)configurationUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _containerView.layer.cornerRadius = 10;
    _iconImageView.layer.cornerRadius = 10;
}

@end
