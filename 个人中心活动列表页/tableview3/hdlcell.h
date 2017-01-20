//
//  Person.h
//  tableview3
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 xkd. All rights reserved.
//

#ifndef Person_h
#define Person_h


#endif /* Person_h */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//这里这个很重要，可以调用ui控件。。。。
@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *headStr;
@property (nonatomic, strong) NSString *speechText;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *noteid;
@property (nonatomic, strong) NSString *status;

@end
