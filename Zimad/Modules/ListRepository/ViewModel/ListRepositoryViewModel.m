//
//  ListRepositoryViewModel.m
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ListRepositoryViewModel.h"

@interface ListRepositoryViewModel ()

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) BOOL isNext;
@property (assign, nonatomic) BOOL isLoading;

@end

@implementation ListRepositoryViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [NetworkService new];
        _isLoading = NO;
        _isNext = YES;
        _isNewList = YES;
        _page = 1;
    }
    return self;
}

- (void)updateRepositories {
    _page = 1;
    _isNext = YES;
    _isNewList = YES;
    [self loadRepositories];
}

- (void)loadRepositories {
    if (_isLoading) {
        return;
    }

    if (self.isNext) {
        _isLoading = YES;
        [self requestRepositories];
    }
}

- (void)requestRepositories {
    [_service getRepositoriesWith:20 page:_page completion:^(RepositoryList *repositoryList, BOOL isError) {
        [self handleRequestRepositories:repositoryList isError:isError];
    }];
}

- (void)handleRequestRepositories:(RepositoryList *)repositoryList isError:(BOOL)isError {
    self.isNext = repositoryList.isNext;

    if (self.isNewList) {
        self.repositoryList = repositoryList;
        self.repositoryList.repositories = repositoryList.repositories;
    } else {
        [self.repositoryList.repositories addObjectsFromArray:repositoryList.repositories];
    }

    self.page++;
    self.completionHandler(update);
    self.isLoading = NO;

    if (isError) {
        self.completionHandler(error);
    }
}

@end
