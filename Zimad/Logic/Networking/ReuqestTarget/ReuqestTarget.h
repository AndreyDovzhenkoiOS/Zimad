//
//  ReuqestTarget.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    repositories
}ReuqestType;

@interface ReuqestTarget : NSObject

@property(assign, nonatomic) ReuqestType type;

- (NSString *)path:(ReuqestType)target;

- (NSArray *)parameters:(ReuqestType)type page:(NSInteger)page perPage:(NSInteger)perPage;

- (NSString *)method:(ReuqestType)target;


+ (ReuqestTarget *)withType:(ReuqestType)type;

@end

