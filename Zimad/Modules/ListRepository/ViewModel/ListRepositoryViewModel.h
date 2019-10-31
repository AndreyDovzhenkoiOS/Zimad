//
//  ListRepositoryViewModel.h
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"

typedef enum{
    update,
    error
}ListRepositoryViewModelType;

@interface ListRepositoryViewModel : NSObject

@property (strong, nonatomic) NetworkService *service;
@property (strong, nonatomic) RepositoryList *repositoryList;
@property (assign, nonatomic) BOOL isNewList;
@property (strong,nonatomic) void(^completionHandler)(ListRepositoryViewModelType type);

- (void)updateRepositories;

- (void)loadRepositories;

- (void)requestRepositories;

@end
