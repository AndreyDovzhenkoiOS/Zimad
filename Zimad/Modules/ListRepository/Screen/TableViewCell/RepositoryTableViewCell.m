//
//  RepositoryTableViewCell.m
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "RepositoryTableViewCell.h"

@interface RepositoryTableViewCell()

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

- (void)configureWith:(Repository *)repository {
    _titleLabel.text = repository.title;
    _nameLabel.text = repository.fullName;
    _descriptionLabel.text = repository.descriptions;
}

- (void)configurationUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _containerView.layer.cornerRadius = 10;
    _iconImageView.layer.cornerRadius = 10;
}

@end
