//
//  MLLabelInternationalExtension.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLLabelInternationalExtension.h"
#import <objc/runtime.h>
#import "MLLanguageManager.h"

@interface UILabel (InternationalExtension)

@property (nonatomic, strong) NSString *internationalKey;

@end



@implementation UILabel (InternationalExtension)

static char _intkey;

- (void)MLLocalizedString:(NSString *)key fromTable:(NSString *)table {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LANGUAGE_CHANGE_NOTI object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshI18N) name:LANGUAGE_CHANGE_NOTI object:nil];
    
    self.internationalKey = key;
    [self refreshI18N];
}

- (void)refreshI18N {
    self.text = MLLocalizedStringFromTable(self.internationalKey, @"Language");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//MKAR: - internationalkey

- (void)setInternationalKey:(NSString *)internationalKey {
    
    objc_setAssociatedObject(self, &_intkey, internationalKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)internationalKey {
    id objc = objc_getAssociatedObject(self, &_intkey);
    return objc;
}

@end
