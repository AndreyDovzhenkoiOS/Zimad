//
//  RepositoryList.h
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryList : NSObject

@property (assign, nonatomic) BOOL isNext;
@property (strong, nonatomic) NSMutableArray* repositories;

+ (RepositoryList *)withDictionary:(NSDictionary *)dictionary;

@end

