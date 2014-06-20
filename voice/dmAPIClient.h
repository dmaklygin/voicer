//
//  dmAPIClient.h
//  voice
//
//  Created by Dmitry Maklygin on 20.06.14.
//  Copyright (c) 2014 Dmitry Maklygin. All rights reserved.
//

#import "AFURLSessionManager.h"

@interface dmAPIClient : AFURLSessionManager

@property (nonatomic, strong) NSString *urlString;

+ (instancetype)sharedClient;

- (void)sendAudio:(NSURL *)filePath withCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
- (void)getAudio:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (NSString *)getAction:(NSString *)action;

@end
