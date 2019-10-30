//
//  Owner.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Owner : NSObject

@property (strong, nonatomic) NSNumber *Id;
@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSURL *avatarUrl;

+(Owner *)withDictionary:(NSDictionary *)dictionary;

@end
