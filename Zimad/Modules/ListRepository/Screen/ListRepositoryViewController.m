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
#import "AlertView.h"

@interface ListRepositoryViewController () <SSARefreshControlDelegate, AlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffect;

@property (strong, nonatomic) RefreshControl *refreshControl;
@property (strong, nonatomic) AlertView *alertView;
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
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    [self configureHeaderView];
}

- (void)configureHeaderView {
    _headerView.clipsToBounds = YES;
    _headerView.layer.cornerRadius = 20;
    _headerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
}

- (void)registerCell {
    UINib *nib = [UINib nibWithNibName: [RepositoryTableViewCell identifier] bundle: nil];
    [_tableView registerNib: nib forCellReuseIdentifier: [RepositoryTableViewCell identifier]];
}

- (void)setupRefreshControl {
    _refreshControl = [[RefreshControl alloc] initWithScrollView:self.tableView andRefreshViewLayerType:SSARefreshViewLayerTypeOnScrollView];
    _refreshControl.delegate = self;
}

- (void)configureAlertView {
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:self options:nil] firstObject];
    _alertView.delegate = self;
    _alertView.center = self.view.center;
    _alertView.frame = CGRectMake(0, 0, 300, 200);
    _alertView.center = self.view.center;
    [self.view addSubview: _alertView];
    
    [_alertView configureWithTitle:@"Message" description:@"Something went wrong! Internet failure or service not working. Try it next time. :("];
    [_alertView setAnimationAletWith:present];
}

- (void)animationHandler:(AlertType)type {
    switch (type) {
        case present:
            _visualEffect.alpha = 1;
            break;
            case dismiss:
            _visualEffect.alpha = 0;
            break;
    }
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
                    [weakSelf configureAlertView];
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
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [_viewModel loadRepositories];
    }
}

@end
