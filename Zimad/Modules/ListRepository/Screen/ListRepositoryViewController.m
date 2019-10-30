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

@interface ListRepositoryViewController () <SSARefreshControlDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    [_viewModel requestRepositories];
}

- (void)configurationUI {
    [self.navigationController.navigationBar setHidden: YES];
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
    _viewModel.completionHandler = ^(NSString *string) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.refreshControl endRefreshing];
            [weakSelf.tableView reloadWithAnimationFadeInTop];
        });
        
    };
}

- (void)beganRefreshing {
    [self loadDataSource];
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1.5);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewModel updateRepositories];
        });
    });
}

- (void)completionHandlers {
    [self.refreshControl endRefreshing];
    [self.tableView reloadWithAnimationFadeInTop];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.repositories.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: [RepositoryTableViewCell identifier]];
    [cell configureWith:_viewModel.repositories[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadWithAnimationFadeInTop];
}


@end
