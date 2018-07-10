//
//  MLUIButton+I18N.h
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/29.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+MLKVO.h"

@interface UIButton(I18N)

- (void)MLI18NTitleKey:(NSString *)key forState:(UIControlState)state;

@end
