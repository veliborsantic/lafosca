//
//  Beach.h
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beach : NSObject

@property BOOL isOpen;
@property (nonatomic, copy) NSNumber *happiness;
@property (nonatomic, copy) NSNumber *dirtiness;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *token;

- (id) initWithToken: (NSString*) tok;
- (void) changeFlag;
- (void) cleanTheBeach;
- (void) searchForLostKids;
- (void) getBeachState;

@end
