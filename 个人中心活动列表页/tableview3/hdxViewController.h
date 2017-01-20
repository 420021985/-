//
//  ViewController.h
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hdlcell.h"
@interface hdxViewController : UIViewController{
    
}
@property (nonatomic, strong) IBOutlet UITableViewCell *hdxcustomCell;
@property (nonatomic, strong) UITableView *hdxtableview;
@property (nonatomic, strong) Person *shuju;
@end

