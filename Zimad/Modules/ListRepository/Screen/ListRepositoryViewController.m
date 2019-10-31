//
//  ListRepositoryViewController.m
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ListRepositoryViewController.h"
#import "RepositoryTableViewCell.h"
#import "ListRepositoryViewModel.h"
#import "NSObject+NSObject.h"
#import "UITableView+UITableView.h"
#import "RefreshControl.h"
#import "DetailedRepositoryViewController.h"

@interface ListRepositoryViewController () <SSARefreshControlDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) RefreshControl *refreshControl;
@property (strong, nonatomic) ListRepositoryViewModel *viewModel;

@end

@implementation ListRepositoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel];
    [self configurationUI];
    [self registerCell];
    [self setupRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden: YES];
    [_viewModel loadRepositories];
    if (_viewModel.repositoryList.repositories.count == 0) {
        [self.activityIndicator startAnimating];
    }
}

- (void)configurationUI {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self configureHeaderView];
}

- (void)configureHeaderView {
    self.headerView.clipsToBounds = YES;
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
}

- (void)registerCell {
    UINib *nib = [UINib nibWithNibName: [RepositoryTableViewCell identifier] bundle: nil];
    [_tableView registerNib: nib forCellReuseIdentifier: [RepositoryTableViewCell identifier]];
}

- (void)setupRefreshControl {
    self.refreshControl = [[RefreshControl alloc] initWithScrollView:self.tableView andRefreshViewLayerType:SSARefreshViewLayerTypeOnScrollView];
    self.refreshControl.delegate = self;
}

- (void)setupViewModel {
    _viewModel = [ListRepositoryViewModel new];
    __weak typeof(self) weakSelf = self;

    _viewModel.completionHandler = ^(ListRepositoryViewModelType type) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (type) {
                case update:
                    [weakSelf.activityIndicator stopAnimating];
                    [weakSelf.refreshControl endRefreshing];
                    if (weakSelf.viewModel.isNewList) {
                        weakSelf.viewModel.isNewList = NO;
                        [weakSelf.tableView reloadWithAnimationFadeInTop];
                    } else {
                        [weakSelf.tableView reloadData];
                    }
                    break;
                case error:
                    break;
            }
        });
    };
}

- (void)beganRefreshing {
    [self loadDataSource];
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewModel updateRepositories];
        });
    });
}

- (void)transitionToDetailedRepository:(NSInteger)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailedRepository" bundle:nil];
    DetailedRepositoryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: [DetailedRepositoryViewController identifier]];
    viewController.viewModel = [DetailedRepositoryViewModel withRepository:_viewModel.repositoryList.repositories[index]];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.repositoryList.repositories.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: [RepositoryTableViewCell identifier]];
    [cell configureWith: _viewModel.repositoryList.repositories[indexPath.row]
                service: _viewModel.service];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self transitionToDetailedRepository:indexPath.row];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >scrollView.contentSize.height - scrollView.frame.size.height) {
        [_viewModel loadRepositories];
    }
}

@end
