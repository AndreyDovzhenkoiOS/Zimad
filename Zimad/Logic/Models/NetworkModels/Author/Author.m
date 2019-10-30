//
//  Author.m
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "Author.h"

@implementation Author

+ (Author*)withDictionary:(NSDictionary *)dictionary {
    Author *author = [Author new];
    author.name = dictionary[@"commit"][@"author"][@"name"];
    author.nameCommit = dictionary[@"commit"][@"message"];
    author.hashCommit = dictionary[@"sha"];
    author.avatarUrl = [NSURL URLWithString: dictionary[@"author"][@"avatar_url"]];
    return author;
}

@end
