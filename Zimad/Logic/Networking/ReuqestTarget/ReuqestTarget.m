//
//  ReuqestTarget.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ReuqestTarget.h"

@interface ReuqestTarget ()

@property (strong, nonatomic) Repository *repository;
@property (assign, nonatomic) NSInteger limit;
@property (assign, nonatomic) NSInteger page;

@end

@implementation ReuqestTarget

+ (ReuqestTarget *)withType:(ReuqestType)type limit:(NSInteger)limit page:(NSInteger)page {
    ReuqestTarget *target = [ReuqestTarget new];
    target.type = type;
    target.limit = limit;
    target.page = page;
    return target;
}

+ (ReuqestTarget *)withType:(ReuqestType)type repository:(Repository *)repository {
    ReuqestTarget *target = [ReuqestTarget new];
    target.type = type;
    target.repository = repository;
    return target;
}

- (NSString *)path:(ReuqestType)type {
    switch (type) {
        case repositories:
            return @"/search/repositories";
            break;
            case detailedRepository:
            return [NSString stringWithFormat:@"/repos/%@/commits/%@", _repository.fullName, _repository.branch];
            break;
    }
    return nil;
}

- (NSArray *)parameters:(ReuqestType)type {
    switch (type) {
        case repositories:
            return @[
                [NSURLQueryItem queryItemWithName:@"q" value:@"language:swift+topic:swift"],
                [NSURLQueryItem queryItemWithName:@"sort" value:@"stars"],
                [NSURLQueryItem queryItemWithName:@"order" value:@"desc"],
                [NSURLQueryItem queryItemWithName:@"per_page" value: [NSString stringWithFormat:@"%ld",(long)_limit]],
                [NSURLQueryItem queryItemWithName:@"page" value: [NSString stringWithFormat:@"%ld",(long)_page]]
            ];
            break;
        case detailedRepository:
            return nil;
            break;
    }
    return nil;
}

- (NSString *)method:(ReuqestType)type {
    switch (type) {
        case repositories:
            return @"GET";
            break;
        case detailedRepository:
             return @"GET";
            break;
    }
    return nil;
}


@end
