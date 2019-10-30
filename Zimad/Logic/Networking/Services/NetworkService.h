//
//  NetworkService.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

-(void)getRepositories:(void (^)(NSArray*))completion;

@end
