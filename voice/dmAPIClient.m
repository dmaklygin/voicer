//
//  dmAPIClient.m
//  voice
//
//  Created by Dmitry Maklygin on 20.06.14.
//  Copyright (c) 2014 Dmitry Maklygin. All rights reserved.
//

#import "dmAPIClient.h"

@implementation dmAPIClient

+ (instancetype)sharedClient
{
    static dmAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedClient = [[dmAPIClient alloc] initWithSessionConfiguration:configuration];
    });
    return _sharedClient;
}

- (void)sendAudio:(NSURL *)filePath withCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    NSError *error;
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[self getAction:@"send_audio"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"audio" fileName:@"myAudio.m4a" mimeType:@"audio/mp4" error:nil];
    } error:&error];
    
    NSURLSessionUploadTask *task = [self uploadTaskWithStreamedRequest:request progress:nil completionHandler:completionHandler];
    [task resume];
}

- (void)getAudio:(void (^)(NSURLSessionDataTask *task, id responseObject))completionHandler
{
//    NSURL *url = [NSURL URLWithString:[self getAction:@"get_audio"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:completionHandler];
//    
//    [task resume];
    [self GET:[self getAction:@"get_audio"] parameters:nil success:completionHandler failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            NSLog(@"Get Audio Error: %@, %@", error, [error userInfo]);
        }
    }];
}


- (NSString *)urlString
{
    if (_urlString) {
        return _urlString;
    }
    
    _urlString = @"http://localhost:3002";
//    _urlString = @"http://voicer-server.herokuapp.com";

    return _urlString;
}

- (NSString *)getAction:(NSString *)action
{
    return (NSString *)[NSMutableString stringWithFormat:@"%@/%@", self.urlString, action];
}

@end
