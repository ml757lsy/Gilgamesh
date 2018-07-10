//
//  MLString+I18N.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/29.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLString+I18N.h"
#import "MLLanguageManager.h"
#import <objc/runtime.h>

@interface NSString(I18N)

@property (nonatomic, strong) NSMutableString *i18nresult;

@end

@implementation NSString(I18N)
static char _toresult;

- (NSString *)MLI18N {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshI18N) name:LANGUAGE_CHANGE_NOTI object:nil];
    [self refreshI18N];
    return self.i18nresult;
}

- (void)refreshI18N {
    NSString *local = MLLocalizedStringFromTable(self, @"Language");
    [self.i18nresult deleteCharactersInRange:NSMakeRange(0, self.i18nresult.length)];
    [self.i18nresult appendString:local];
    NSLog(@"%d",self.i18nresult);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//
- (NSMutableString *)i18nresult {
    id ir = objc_getAssociatedObject(self, &_toresult);
    if (ir == nil) {
        
        NSMutableString * s = [[NSMutableString alloc]initWithString:@""];
        [self setI18nresult:s];
        return s;
    }
    return ir;
}

- (void)setI18nresult:(NSMutableString *)i18nresult {
    objc_setAssociatedObject(self, &_toresult, i18nresult, OBJC_ASSOCIATION_RETAIN);
}


@end
