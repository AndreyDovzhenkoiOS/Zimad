//
//  NetworkService.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryList.h"
#import "Author.h"
#import "Repository.h"

@interface NetworkService : NSObject

- (void)getRepositoriesWith:(NSInteger)limit page:(NSInteger)page completion:(void (^)(RepositoryList*, BOOL))completion;

- (void)getDetailedRepositoryWith:(Repository *)repository completion:(void (^)(Author*, BOOL))completion;

- (void)getImageWithUrl:(NSURL *)url completion:(void (^)(UIImage *))completion;

@end
