//
//  DetailedRepositoryViewModel.m
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "DetailedRepositoryViewModel.h"

@interface DetailedRepositoryViewModel()

@property (strong, nonatomic) NetworkService *service;

@end

@implementation DetailedRepositoryViewModel

+ (DetailedRepositoryViewModel *)withRepository:(Repository *)repository {
    DetailedRepositoryViewModel *viewModel = [DetailedRepositoryViewModel new];
    viewModel.repository = repository;
    return viewModel;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [NetworkService new];
    }
    return self;
}


- (void)requestDetailedRepository {
    [_service getDetailedRepositoryWith: _repository completion:^(Author *author) {
        self.completionHandler(author);
        [self loadAvatarWith: [NSURL URLWithString:author.avatarUrl]];
    }];
}

- (void)loadAvatarWith:(NSURL *)url {
    [_service getImageWithUrl:url completion:^(UIImage *image) {
        self.completionHandlerAvatar(image);
    }];
}

@end
