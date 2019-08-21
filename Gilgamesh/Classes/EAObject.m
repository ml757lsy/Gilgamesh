//
//  EAObject.m
//  Gilgamesh
//
//  Created by 李世远 on 2018/5/23.
//

#import "EAObject.h"
#import "AFNetworking.h"

@implementation EAObject

- (void)Enumaelish {
    NSLog(@"Enuma elish!");
    
    NSString *path = [NSBundle mainBundle].bundlePath;
    
    NSLog(path);
    
    [self requestSomething];
}

- (void)requestSomething {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    manager.requestSerializer.timeoutInterval = 30;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"aoolication/xml",@"text/xml",@"text/html",@"text/json",@"application/json",@"text/plain", nil];
    
    
    //
    NSString *url = @"https://www.baidu.com";
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //
        NSLog(@"downloadProgress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSLog(@"success");

        if([NSJSONSerialization isValidJSONObject:responseObject]) {
            NSLog(@"JSON");
        }else{
            NSData *d = (NSData *)responseObject;
            NSString *s = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"error");
        NSLog(@"%@%@",task,error);
    }];
    
    [manager POST:@"" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
    
}

@end
