//
//  MLLabelInternationalExtension.h
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (InternationalExtension)

- (void)MLLocalizedString:(NSString *)key fromTable:(NSString *)table;

@end
