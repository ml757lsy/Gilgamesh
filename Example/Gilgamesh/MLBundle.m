//
//  MLBundle.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/25.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLBundle.h"
#import "MLBundleExtension.h"

@implementation MLBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = self.languageBundle;
    NSLog(@"%@",bundle);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }else{
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end
