//
//  RepositoryTableViewCell.h
//  Zimad
//
//  Created by Andrey on 10/24/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"

@interface RepositoryTableViewCell : UITableViewCell

- (void)configureWith:(Repository *)repository service:(NetworkService*)service;

@end
