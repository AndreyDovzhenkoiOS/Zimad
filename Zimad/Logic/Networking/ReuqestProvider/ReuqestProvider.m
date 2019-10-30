//
//  ReuqestProvider.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "ReuqestProvider.h"

@implementation ReuqestProvider

- (void)request:(ReuqestTarget *)target completion:(void (^)(NSError*, NSURLResponse*, NSData*))completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self url: target]];
    request.HTTPMethod = [target method: target.type];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [[self createDataTask:request completion: completion] resume];
}

- (NSURL*)url:(ReuqestTarget *)target {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = @"api.github.com";
    components.path = [target path:target.type];
    components.queryItems = [target parameters:target.type page:1 perPage:20];
    return components.URL;
}

- (NSURLSessionDataTask *)createDataTask:(NSURLRequest *)request completion:(void (^)(NSError*, NSURLResponse*, NSData*))completion {
    return [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(error, response, data);
        });
        
    }];
}

@end
