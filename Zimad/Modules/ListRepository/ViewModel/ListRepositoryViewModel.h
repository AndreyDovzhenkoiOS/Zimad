//
//  ListRepositoryViewModel.h
//  Zimad
//
//  Created by Andrey on 10/23/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListRepositoryViewModel : NSObject

@property (strong, nonatomic) NSArray *repositories;
@property(strong,nonatomic)void(^completionHandler)(NSString*string);

- (void)requestRepositories;
- (void)updateRepositories;

@end
