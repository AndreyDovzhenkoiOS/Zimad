//
//  Author.h
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (strong, nonatomic) NSURL *avatarUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameCommit;
@property (strong, nonatomic) NSString *hashCommit;

+ (Author *)withDictionary:(NSDictionary *)dictionary;

@end
