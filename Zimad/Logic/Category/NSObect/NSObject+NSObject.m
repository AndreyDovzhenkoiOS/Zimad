//
//  NSObject+NSObject.m
//  Zimad
//
//  Created by Andrey on 10/25/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "NSObject+NSObject.h"

@implementation NSObject (NSObject)

+ (NSString *)identifier {
    return [NSString stringWithFormat:@"%@", self];
}

@end
