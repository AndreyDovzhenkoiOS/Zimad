//
//  Repository.m
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "Repository.h"

@implementation Repository

+ (Repository*)withDictionary:(NSDictionary *)dictionary {
    Repository *repository = [Repository new];

    repository.Id = dictionary[@"id"];
    repository.title = dictionary[@"name"];
    repository.fullName = dictionary[@"full_name"];
    repository.url = dictionary[@"url"];
    repository.branch = dictionary[@"default_branch"];
    repository.descriptions = dictionary[@"description"];
    repository.owner = [Owner withDictionary:dictionary[@"owner"]];

    return repository;
}
@end
