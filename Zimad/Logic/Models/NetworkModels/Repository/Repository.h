//
//  Repository.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

@property (assign, nonatomic) NSNumber *repositoryId;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSString *branch;
@property (strong, nonatomic) NSString *avatarUrl;

+ (Repository *)withDictionary:(NSDictionary *)dictionary;

@end
