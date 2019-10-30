//
//  ReuqestProvider.h
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReuqestTarget.h"

@interface ReuqestProvider : NSObject

- (void)request:(ReuqestTarget *)target completion:(void (^)(NSError*, NSURLResponse*, NSData*))completion;

@end
