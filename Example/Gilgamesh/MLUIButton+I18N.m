//
//  MLUIButton+I18N.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/29.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLUIButton+I18N.h"
#import <objc/runtime.h>
#import "MLLanguageManager.h"

@interface UIButton(I18N)

@property (nonatomic, strong) NSMutableDictionary *keystate;

@end

@implementation UIButton(I18N)
static char _intkey;
//MARK: - key
- (void)setKeystate:(NSMutableDictionary *)keystate {
    objc_setAssociatedObject(self, &_intkey, keystate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)keystate {
    
    id k = objc_getAssociatedObject(self, &_intkey);
    
    if (k != nil) {
        return k;
    }
    return [[NSMutableDictionary alloc]init];
}

//
/**
 //

 @param key //
 @param state //
 @code - (void)MLI18NTitleKey:(NSString *)key forState:(UIControlState)state{
 return;
 }
 */
- (void)MLI18NTitleKey:(NSString *)key forState:(UIControlState)state{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LANGUAGE_CHANGE_NOTI object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshI18N) name:LANGUAGE_CHANGE_NOTI object:nil];
    
    [self performSelector:@selector(observerForKeypath:) withObject:@"" afterDelay:1];
    
    NSMutableDictionary *dic = self.keystate;
    NSString *s = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)state];
    [dic setValue:key forKey:s];
    self.keystate = dic;
    [self refreshI18N];
}

- (void)refreshI18N {
    for (NSString *state in [self.keystate allKeys]) {
        UIControlState ss = [state longLongValue];
        NSString *key = [self.keystate valueForKey:state];
        [self setTitle:MLLocalizedStringFromTable(key, @"Language") forState:ss];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
