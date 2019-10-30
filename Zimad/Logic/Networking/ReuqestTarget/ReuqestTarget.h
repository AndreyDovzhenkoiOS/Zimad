//
//  ReuqestTarget.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repository.h"

typedef enum{
    repositories,
    detailedRepository
}ReuqestType;

@interface ReuqestTarget : NSObject

@property(assign, nonatomic) ReuqestType type;

- (NSString *)path:(ReuqestType)target;

- (NSArray *)parameters:(ReuqestType)type;

- (NSString *)method:(ReuqestType)target;

+ (ReuqestTarget *)withType:(ReuqestType)type limit:(NSInteger)limit page:(NSInteger)page;

+ (ReuqestTarget *)withType:(ReuqestType)type repository:(Repository *)repository;

@end

