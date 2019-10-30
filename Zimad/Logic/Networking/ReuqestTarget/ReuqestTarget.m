//
//  ReuqestTarget.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ReuqestTarget.h"

@implementation ReuqestTarget

+ (ReuqestTarget *)withType:(ReuqestType)type {
    ReuqestTarget *target = [ReuqestTarget new];

    target.type = type;

    return target;
}

- (NSString *)path:(ReuqestType)type {
    switch (type) {
        case repositories:
            return [NSString stringWithFormat:@"/search/repositories"];
            break;
    }
    return nil;
}

- (NSArray *)parameters:(ReuqestType)type page:(NSInteger)page perPage:(NSInteger)perPage {
    switch (type) {
        case repositories:
            return @[
                [NSURLQueryItem queryItemWithName:@"q" value:@"language:swift+topic:swift"],
                [NSURLQueryItem queryItemWithName:@"sort" value:@"stars"],
                [NSURLQueryItem queryItemWithName:@"order" value:@"desc"],
                [NSURLQueryItem queryItemWithName:@"per_page" value: [NSString stringWithFormat:@"%ld",(long)perPage]],
                 [NSURLQueryItem queryItemWithName:@"page" value: [NSString stringWithFormat:@"%ld",(long)page]]
            ];
            break;
    }
    return nil;
}

- (NSString *)method:(ReuqestType)type {
    switch (type) {
        case repositories:
            return [NSString stringWithFormat:@"GET"];
            break;
    }
    return nil;
}


@end
