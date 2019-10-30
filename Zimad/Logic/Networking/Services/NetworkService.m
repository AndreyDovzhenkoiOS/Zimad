//
//  NetworkService.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "NetworkService.h"
#import "ReuqestProvider.h"
#import "Repository.h"

@interface NetworkService ()

@property (strong, nonatomic) ReuqestProvider *provider;

@end

@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _provider = [ReuqestProvider new];
    }
    return self;
}

-(void)getRepositories:(void (^)(NSArray*))completion {
    [_provider request:[ReuqestTarget withType: repositories]
                completion:^(NSError *error, NSURLResponse *response, NSData *data) {
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *items = [NSMutableArray new];
            for (NSDictionary *item in [json valueForKey:@"items"]) {
                [items addObject: [Repository withDictionary:item]];
            }
            completion(items);
        }
    }];
}

@end
