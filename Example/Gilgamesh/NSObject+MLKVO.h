//
//  NSObject+MLKVO.h
//  Gilgamesh_Example
//
//  Created by 李世远 on 2018/6/4.
//  Copyright © 2018年 LiShiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSObject(MLKVO)

/**
 检查对象是否已经监听某keypath
 
 @param keypath keypath
 @return YES/NO
 */
- (BOOL)observerForKeypath:(NSString *)keypath;

@end
