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
    
    [self getBeachState];
    
   }

- (void) getBeachState
{
    // Prepare URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lafosca-beach.herokuapp.com/api/v1/state"]];
    [self sendAuthorizationWithRequest:request andMethod:@"GET"];
}

- (void) sendAuthorizationWithRequest:(NSMutableURLRequest *)request andMethod:(NSString *)method
{
    // Define token
    NSString *authString = [NSString stringWithFormat:@"Token token=\"%@\"", self.token];
    
    // Set header and method
    [request setValue:authString forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];
    
    // And make request
    [self makeRequestWithRequest:request];
}

- (void) makeRequestWithRequest: (NSMutableURLRequest*) request
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    // Get request and response though URL
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // JSON parsing
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    Beach *beach = [[Beach alloc] init];
    
    if ([[result objectForKey:@"state"] isEqualToString:@"open"]) {
        NSLog(@"The beach is open :-)");
        // set variables
        beach.state = 1;
        beach.dirtiness = [result valueForKey:@"dirtiness"];
        beach.happiness = [result valueForKey:@"happiness"];
        beach.flag = [result valueForKey:@"flag"];
        beach.kids = [result valueForKey:@"kids"];
    }
    else
    {
        
        NSLog(@"The beach is closed :-)");
        beach.state = 0;
        beach.dirtiness = nil;
        beach.happiness = nil;
        beach.flag = nil;
        beach.kids = nil;
    }
    
    // No need to pass all the vars, it is enough just to pass NSDictionary
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BeachTableViewController *btvc = (BeachTableViewController*)[sb instantiateViewControllerWithIdentifier:@"BeachTableViewController"];
    btvc.beachData = result;
    [self presentViewController:btvc animated:YES completion:nil];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
