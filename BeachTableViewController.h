//
//  BeachTableViewController.h
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeachTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *beachData;

@end
