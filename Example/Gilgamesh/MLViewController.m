//
//  MLViewController.m
//  Gilgamesh
//
//  Created by LiShiyuan on 05/23/2018.
//  Copyright (c) 2018 LiShiyuan. All rights reserved.
//

#import "MLViewController.h"
#import "EAObject.h"
#import "MLLanguageManager.h"
#import "MLLabelInternationalExtension.h"
#import "MLUIButton+I18N.h"
#import "MLString+I18N.h"

@interface MLViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) NSString *i18nstr;

@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    EAObject *ea = [[EAObject alloc]init];
    [ea Enumaelish];
    
    NSString *path = [NSBundle mainBundle].bundlePath;
    NSLog(path);
    
    NSString *s = MLLocalizedStringFromTable(@"language", @"Language");
    NSLog(@"%@", s);
    
    NSArray *l = [[NSUserDefaults standardUserDefaults]valueForKey:@"AppleLanguages"];
    NSLog(@"%@", l);
    
    NSArray *codes = [NSLocale ISOLanguageCodes];
//    NSLog(@"%@",codes);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    button.frame = CGRectMake(20, 20, self.view.frame.size.width-40, 40);
    [button setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [button MLI18NTitleKey:@"language" forState:UIControlStateNormal];
    [button MLI18NTitleKey:@"test" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(changeLanguage) forControlEvents:UIControlEventTouchUpInside];
    
    self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, self.view.frame.size.width-40, 40)];
    [self.view addSubview:self.showLabel];
    [self.showLabel MLLocalizedString:@"test" fromTable:@"Language"];
    
    //
    UILabel *test = [[UILabel alloc]initWithFrame:CGRectMake(20, 140, self.view.frame.size.width-40, 40)];
    [self.view addSubview:test];
    test.text = NSLocalizedStringFromTable(@"language", @"Language", @"");//copy引用 更新无效
    
}

- (void)changeLanguage {
    [[MLLanguageManager shareManager]changeLanguage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
