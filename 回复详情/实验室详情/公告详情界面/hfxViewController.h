//
//  ViewController.h
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hfxcell.h"

@interface hfxViewController : UIViewController{
    
}
@property (nonatomic, strong) IBOutlet UITableViewCell *hfxcustomCell;
@property (nonatomic, strong) UITableView *hfxtableview;
@property (nonatomic, strong) hfxshang *ya;
@end

