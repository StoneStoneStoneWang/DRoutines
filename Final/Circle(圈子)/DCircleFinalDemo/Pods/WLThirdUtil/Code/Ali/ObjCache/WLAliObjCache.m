//
//  WLAliObjCache.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAliObjCache.h"
#import "AliyunOSSiOS.h"

@interface WLAliObjCache()

@property (nonatomic ,copy) NSString *bucketName;

@property (nonatomic ,copy) NSString *endpoint;
@end

@implementation WLAliObjCache

+ (instancetype)shared {
    static WLAliObjCache *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [WLAliObjCache new];
    });
    return manager;
}

+ (void)prepare:(NSString *)bucketName andEndPoint:(NSString *)endpoint {
    
    [WLAliObjCache shared].bucketName = bucketName;
    
    [WLAliObjCache shared].endpoint = endpoint;
}

- (BOOL )checkEnv {
    
    return [WLAliObjCache shared].bucketName && [WLAliObjCache shared].endpoint;
}


- (void)uploadData:(NSData *)data andProjectKey:(NSString *)projectKey andAccessKeyId:(NSString *)accessKeyId andAccessKeySecret:(NSString *)accessKeySecret andSecurityToken:(NSString *)securityToken andProgress:(void (^) (int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend))progress andSucc:(void (^)(NSString * _Nonnull))succ andFail:(void (^)(NSError * _Nonnull))fail {
    
    if (![self checkEnv]) {
        
        NSLog(@"不安全的环境");
        
        return;
    }
    
    OSSPutObjectRequest *request = [OSSPutObjectRequest new];
    
    request.objectKey = projectKey;
    
    request.uploadingData = data;
    
    request.bucketName = [WLAliObjCache shared].bucketName;
    
    request.uploadProgress = progress;
    
    OSSStsTokenCredentialProvider *provider = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyId secretKeyId:accessKeySecret securityToken:securityToken];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:[WLAliObjCache shared].endpoint credentialProvider:provider];
    
    OSSTask *task = [client putObject:request];
    
    [[task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        
        if (task.error) { fail(task.error); }
        
        else { succ(projectKey); }
        
        return task;
    }] waitUntilFinished] ;
}

@end
