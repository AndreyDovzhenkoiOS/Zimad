//
//  UITableView+UITableView.m
//  Zimad
//
//  Created by Andrey on 10/29/19.
//  Copyright © 2019 Andrey Dovzhenko. All rights reserved.
//

#import "UITableView+UITableView.h"

@implementation UITableView (UITableView)

- (void)reloadWithAnimationFadeInTop {
    [self reloadData];
    for (int index = 0; index < self.visibleCells.count; index++) {
        UITableViewCell *cell = self.visibleCells[index];
        cell.alpha = 0;
        cell.transform = CGAffineTransformMakeScale(0.8, 0.8);

        [UIView animateWithDuration: 0.7
                              delay: 0.07 * index
             usingSpringWithDamping: 0.7
              initialSpringVelocity: 0.1
                            options: UIViewAnimationOptionCurveLinear animations:^{
            cell.alpha = 1;
            cell.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
