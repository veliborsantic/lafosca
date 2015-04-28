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
    self.username.text = @"velo";
    self.password.text = @"12345";
}

- (IBAction) signIn
{
    // Prepare URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lafosca-beach.herokuapp.com/api/v1/user"]];
    
    // Prepare what to send
    NSString *authString = [NSString stringWithFormat:@"%@:%@", self.username.text, self.password.text];
    NSData *authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64AuthData = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64AuthData];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    [self makeRequest:request];
}

- (IBAction) signUp
{
    // Prepare URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lafosca-beach.herokuapp.com/api/v1/users"]];
    
    // Prepare what to send
    NSString *authString = [NSString stringWithFormat:@"{\"user\":{\"username\":\"%@\", \"password\": \"%@\"}}", self.username.text, self.password.text];
    NSData *authData = [authString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authDataLength = [NSString stringWithFormat:@"%lu", [authData length]];
    [request setHTTPBody:authData];
    [request setHTTPMethod:@"POST"];
    [request setValue:authDataLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self makeRequest:request];
}

- (void) makeRequest: (NSMutableURLRequest*) request
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    // Get request and response though URL
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // JSON Parsing
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    [self grabToken:result];
}

- (void) grabToken: (NSDictionary*) dict
{
    self.token=[dict objectForKey:@"authentication_token"];
    NSLog(@"Token: %@", self.token);
    
    Beach *beach = [[Beach alloc] initWithToken:self.token];
    [beach getBeachState];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
