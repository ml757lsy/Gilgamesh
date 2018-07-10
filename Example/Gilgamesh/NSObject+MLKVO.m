//
//  NSObject+MLKVO.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/6/4.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "NSObject+MLKVO.h"
#import <objc/runtime.h>

@implementation NSObject(MLKVO)

+ (void)init{
    [self switchFunction];
}

- (void)addMLObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if (![self observerForKeypath:keyPath]) {//不存在再添加防止重复
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
    
}

- (void)removeMLObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    if ([self observerForKeypath:keyPath]) {//存在再删除，防止崩溃
        [self removeObserver:observer forKeyPath:keyPath];
    }
}

- (void)removeMLObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0)) {
    if ([self observerForKeypath:keyPath]) {//存在再删除，防止崩溃
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
}


- (BOOL)observerForKeypath:(NSString *)keypath {
    id info = self.observationInfo;
    NSArray *observances = [info valueForKey:@"_observances"];
    for (id obser in observances) {
        id property = [obser valueForKey:@"_property"];
        NSString *path = [property valueForKey:@"_keyPath"];
        if ([keypath isEqualToString:path]) {
            return YES;
        }
    }
    return NO;
}

+ (void)switchFunction {
    SEL remove = @selector(removeObserver:);
    SEL mlremove = @selector(removeMLObserver:forKeyPath:);
    
    SEL add = @selector(addObserver:forKeyPath:options:context:);
    SEL mladd = @selector(addMLObserver:forKeyPath:options:context:);
    
    Method sysRemove = class_getClassMethod([self class], remove);
    Method mlRemove = class_getClassMethod([self class], mlremove);
    Method sysAdd = class_getClassMethod([self class], add);
    Method mlAdd =  class_getClassMethod([self class], mladd);
    
    method_exchangeImplementations(sysRemove, mlRemove);
    method_exchangeImplementations(sysAdd, mlAdd);
}

@end
