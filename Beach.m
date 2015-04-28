//
//  Beach.m
//  Lafosca
//
//  Created by velo on 28/04/15.
//  Copyright (c) 2015 veloapps.com. All rights reserved.
//

#import "Beach.h"

@implementation Beach

- (id) initWithToken: (NSString*) tok
{
    if (self) {
        self.token = tok;
    }
    return self;
}

- (void) changeFlag
{}

- (void) cleanTheBeach
{

}

-(void) searchForLostKids
{}

- (void) getBeachState
{
    // Prepare URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lafosca-beach.herokuapp.com/api/v1/state"]];
    
    // Prepare what to send
    NSString *authString = [NSString stringWithFormat:@"token=\"%@\"", self.token];
    NSData *authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64AuthData = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"%@", base64AuthData];
    [request setValue:authValue forHTTPHeaderField:@"Authorization Token"];
    [request setHTTPMethod:@"GET"];
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
    NSLog(@"Result je : %@", result);
    NSLog(@"Code is %lu", response.statusCode);
}

@end
