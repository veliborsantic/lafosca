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
    
    // Make URL request
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    // Get request and response though URL
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // JSON Parsing
    if (responseData) {
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Token = %@",result);
    }
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
    
    // Make URL request
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    // Get request and response though URL
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // JSON Parsing
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Token = %@",[result objectForKey:@"authentication_token"]);
    self.token = [result objectForKey:@"authentication_token"];
    NSLog(@"Response code = %li", response.statusCode); //if 201, then it is ok
    
    // Give me beach state
 //   Beach *beach = [[Beach alloc] init];
  //  [beach getBeachState];
}

- (void) setToken
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
