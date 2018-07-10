//
//  MLBundleExtension.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/25.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLBundleExtension.h"
#import "MLLanguageManager.h"
#import <objc/runtime.h>
#import "MLBundle.h"

@implementation NSBundle(MLBundleExtension)

- (void)onLanguage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [MLBundle class]);
    });
}

- (NSBundle *)languageBundle{
    return [[MLLanguageManager shareManager] languageBundle];
}

@end
