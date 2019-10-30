//
//  NetworkService.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "NetworkService.h"
#import "ReuqestProvider.h"

@interface NetworkService ()

@property (strong, nonatomic) ReuqestProvider *provider;
@property (strong, nonatomic) NSURLCache *cache;

@end


@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _provider = [ReuqestProvider new];
        _cache = NSURLCache.sharedURLCache;
    }
    return self;
}

- (void)getRepositoriesWith:(NSInteger)limit page:(NSInteger)page completion:(void (^)(RepositoryList*))completion {
    [_provider request:[ReuqestTarget withType: repositories limit:limit page:page]
                completion:^(NSError *error, NSURLResponse *response, NSData *data) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
            if (httpResponse.statusCode == 200) {
              completion([RepositoryList withDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]]);
            }
        }
    }];
}

- (void)getDetailedRepositoryWith:(Repository *)repository completion:(void (^)(Author*))completion {
    [_provider request:[ReuqestTarget withType: detailedRepository repository:repository] completion:^(NSError *error, NSURLResponse *response, NSData *data) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
            if (httpResponse.statusCode == 200) {
              completion([Author withDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]]);
            }
        }
    }];
}

- (void)getImageWithUrl:(NSURL *)url completion:(void (^)(UIImage *))completion {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSCachedURLResponse *response = [_cache cachedResponseForRequest:request];
      [self downloadImageWith:request completion:completion];
    if (response) {
        completion([UIImage imageWithData: response.data]);
    } else {
        [self downloadImageWith:request completion:completion];
    }
}

- (void)downloadImageWith:(NSURLRequest *)request completion:(void (^)(UIImage *))completion {
    [[_provider createDataTask:request completion:^(NSError *error, NSURLResponse *response, NSData *data) {
        NSCachedURLResponse *cached = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
        [self.cache storeCachedResponse:cached forRequest:request];
        completion([UIImage imageWithData:data]);
    }] resume];
}

@end
