//
//  ViewController.m
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lafosca-beach.herokuapp.com/api/v1/users"]];
    
    NSString *authString = @"?username=velo&password=12345";
    NSData *authData = [NSData dataWithBytes:[authString UTF8String] length:[authString length]];
    NSString *authDataLength = [NSString stringWithFormat:@"%li", [authData length]];
    [request setHTTPBody:authData];
    [request setHTTPMethod:@"POST"];
    [request setValue:authDataLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //-- Make URL request with server
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    //-- Get request and response though URL
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //-- JSON Parsing
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Result = %@",result);
    NSLog(@"Response code = %li", response.statusCode);
    for (NSMutableDictionary *dic in result)
    {
        NSString *string = dic[@"array"];
        if (string)
        {
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            dic[@"array"] = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        else
        {
            NSLog(@"Error in url response");
        }
    }}

- (void) registerUser
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
