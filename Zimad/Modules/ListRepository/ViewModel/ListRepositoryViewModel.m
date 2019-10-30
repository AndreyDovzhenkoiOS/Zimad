//
//  ListRepositoryViewModel.m
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ListRepositoryViewModel.h"
#import "NetworkService.h"

@interface ListRepositoryViewModel ()

@property (strong, nonatomic) NetworkService *service;

@end

@implementation ListRepositoryViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [NetworkService new];
    }
    return self;
}

- (void)updateRepositories {
    [self requestRepositories];
}

- (void)requestRepositories {
    [_service getRepositories:^(NSArray *items) {
        self.repositories = items;
        self.completionHandler(@"fdsfsd");
    }];
}

@end
