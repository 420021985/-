//
//  ViewController.h
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ggxiangViewController : UIViewController{
    
}
@property (nonatomic, strong) IBOutlet UITableViewCell *ggxiangcustomCell;
@property (nonatomic, strong) UITableView *ggxiangtableview;
@property (nonatomic, strong) Person *president;
@property (nonatomic, strong) NSString *shuju;
@end

