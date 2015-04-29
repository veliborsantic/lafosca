//
//  Beach.h
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeachTableViewController.h"

@interface Beach : NSObject

@property BOOL state;
@property (nonatomic, copy) NSNumber *flag;
@property (nonatomic, copy) NSNumber *happiness;
@property (nonatomic, copy) NSNumber *dirtiness;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSDictionary *kids;

- (id) initWithToken: (NSString*) tok;
- (void) changeFlag;
- (void) cleanTheBeach;
- (void) searchForLostKids;

@end
