//
//  MLLanguageManager.h
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/25.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define MLLocalizedStringFromTable(key, tbl) [[MLLanguageManager shareManager]getLocalStringForKey:key andTable:tbl andComment:nil]

#define LANGUAGE_CHANGE_NOTI @"language_change_notifaction"

@interface MLLanguageManager : NSObject

+(id)shareManager;

- (NSString *)getLocalStringForKey:(NSString *)key andTable:(NSString *)table andComment:(nullable NSString *)comment;

- (void)changeLanguage;

/**
 设置新语言

 @param language 语言
 */
- (void)setNewLanguage:(NSString *)language;

@end
