//
//  JSObjcDelegate.h
//  JSTest
//
//  Created by 安宁 on 2017/8/31.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

- (void)callCamera;
- (void)share:(NSString *)shareString;

@end
