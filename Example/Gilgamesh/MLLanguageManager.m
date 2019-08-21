//
//  MLLanguageManager.m
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/25.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import "MLLanguageManager.h"
#import "MLBundleExtension.h"

#define LANGUAGE_SET @"languagesets"
#define EN @"en"
#define CNS @"zh-Hans"

static MLLanguageManager *manager;

@interface MLLanguageManager()

@property(nonatomic, copy) NSString *language;
@property(nonatomic, strong) NSBundle *bundle;
@property(nonnull, strong) NSMutableArray *languageList;

@end

@implementation MLLanguageManager

+(id)shareManager{
    
    if (!manager) {
        manager = [[MLLanguageManager alloc]init];
    }
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLanaguage];
    }
    
    return self;
}

- (void) initLanaguage {
    //list
    self.languageList = [NSMutableArray array];
    NSArray *suport = [[NSBundle mainBundle] pathsForResourcesOfType:@"lproj" inDirectory:nil];
    for (NSString *path in suport) {
        NSString *l = [[path componentsSeparatedByString:@"/"].lastObject componentsSeparatedByString:@"."].firstObject;
        if (![l isEqualToString:@"Base"]) {
            [self.languageList addObject:l];
        }
    }
    NSLog(@"%@",self.languageList);
    
    //lan
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_SET];
    NSString *path;
    
    if (!temp) {
        temp = CNS;
    }else{
        temp = EN;
    }
    
    self.language = temp;
    path = [[NSBundle mainBundle]pathForResource:temp ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)getLocalStringForKey:(NSString *)key andTable:(NSString *)table andComment:(NSString *)comment{
    
    if (self.bundle) {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, comment);
    }
    
    [self.bundle localizedStringForKey:key value:@"" table:table];
    
    return NSLocalizedStringFromTable(key, table, comment);
}

- (void)changeLanguage {
    if ([self.language isEqualToString:EN]) {
        [self setNewLanguage:CNS];
    }else{
        [self setNewLanguage:EN];
    }
    
}

- (void)setNewLanguage:(NSString *)language {
    if (language == self.language) {
        return;
    }
    
    if (![self.languageList containsObject:language]) {
        language = EN;
    }
    
    if ([language isEqualToString:EN]||[language isEqualToString:CNS]) {
        //
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    
    self.language = language;
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:LANGUAGE_SET];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self refreshLanguage];
}

- (void)refreshLanguage{
    //1.noti???  复杂 效果好
    [[NSNotificationCenter defaultCenter]postNotificationName:LANGUAGE_CHANGE_NOTI object:self.language.copy];
    
    //2.改bundle 简单 效果不好
    [[NSBundle mainBundle]onLanguage];
    
}

@end

