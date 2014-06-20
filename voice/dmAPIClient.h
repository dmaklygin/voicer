//
//  dmAPIClient.h
//  voice
//
//  Created by Dmitry Maklygin on 20.06.14.
//  Copyright (c) 2014 Dmitry Maklygin. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface dmAPIClient : AFHTTPSessionManager

@property (nonatomic, strong) NSString *urlString;

+ (instancetype)sharedClient;

- (void)sendAudio:(NSURL *)filePath withCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
- (void)getAudio:(void (^)(NSURLSessionDataTask *task, id responseObject))completionHandler;

- (NSString *)getAction:(NSString *)action;


@end
