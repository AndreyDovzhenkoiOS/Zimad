//
//  RepositoryList.m
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "RepositoryList.h"
#import "Repository.h"

@implementation RepositoryList

+ (RepositoryList *)withDictionary:(NSDictionary *)dictionary {
    
    RepositoryList *repositoryList = [RepositoryList new];
    repositoryList.isNext = dictionary[@"incomplete_results"];

    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *item in [dictionary valueForKey:@"items"]) {
        [items addObject: [Repository withDictionary:item]];
    }
    repositoryList.repositories = items;

    return repositoryList;
}

@end
