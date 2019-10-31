//
//  DetailedRepositoryViewModel.h
//  Zimad
//
//  Created by Andrey on 10/30/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"

@interface DetailedRepositoryViewModel : NSObject

@property (strong, nonatomic) Repository *repository;
@property (strong, nonatomic) Author *author;

@property (strong, nonatomic) void(^completionHandlerAvatar)(UIImage* image);
@property (strong, nonatomic) void(^completionHandler)(Author* author);
@property (strong,nonatomic)void(^completionHandlerError)(void);

+ (DetailedRepositoryViewModel *)withRepository:(Repository *)repository;

- (void)requestDetailedRepository;

@end
