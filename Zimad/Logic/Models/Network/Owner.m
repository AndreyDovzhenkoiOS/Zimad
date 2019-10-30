//
//  Owner.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "Owner.h"

@implementation Owner

+ (Owner*)withDictionary:(NSDictionary *)dictionary {
    Owner *owner = [Owner new];

    owner.Id = dictionary[@"id"];
    owner.login = dictionary[@"login"];
    owner.avatarUrl = [NSURL URLWithString:dictionary[@"avatar_url"]];

    return owner;
}

@end
