//
//  DetailedRepositoryViewController.m
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "DetailedRepositoryViewController.h"
#import "UIView+UIView.h"

@interface DetailedRepositoryViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *branchLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameComitLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hashComitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImaveView;

@end

@implementation DetailedRepositoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self completionHandlers];
    [self configureUI];
    [self configureHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel requestDetailedRepository];
}

- (void)configureUI {
    _avatarImaveView.layer.cornerRadius = 10;
    [_avatarImaveView setupShadow:5 opacity:0.5 height:5];
}

- (void)configureHeaderView {
    self.headerView.clipsToBounds = YES;
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
}

- (void)completionHandlers {
     __weak typeof(self) weakSelf = self;

    _viewModel.completionHandlerAvatar = ^(UIImage *image){
        weakSelf.avatarImaveView.image = image;
    };
    
    _viewModel.completionHandler= ^(Author *author){
        [weakSelf configureWith:author];
    };
}

- (void)configureWith:(Author *)author {
    _nameLabel.text = author.name;
    _hashComitLabel.text = author.hashCommit;
    _nameComitLabel.text = author.nameCommit;
    _branchLabel.text = _viewModel.repository.branch;
}

- (IBAction)extitAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
