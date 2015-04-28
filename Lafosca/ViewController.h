//
//  ViewController.h
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Beach.h"
#import "BeachTableViewController.h"

@interface ViewController : UIViewController

// UI
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


@property (nonatomic, copy) NSString *token;

@end

