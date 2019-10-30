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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

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
    [self.activityIndicator startAnimating];
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
        [weakSelf.activityIndicator stopAnimating];
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
