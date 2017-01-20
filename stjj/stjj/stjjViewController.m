//
//  ViewController.m
//  stjj
//
//  Created by apple on 2017/1/19.
//  Copyright © 2017年 xkd. All rights reserved.
//

#import "stjjViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@property (nonatomic ,strong) NSString*noteid;
@property (nonatomic ,strong) NSString*url;
@property (nonatomic ,strong) NSString*typename;

@property (nonatomic ,strong) NSString*jj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteid=@"110";
    _url=@"http://www.jialeshequ.com/upload/note/20160906/147314486564074.jpg";
    _typename=@"志愿服务";
    _jj=@"2333333333333333333333333333333333333335345464565756745634524512343253465475676576576575674563452345235";
    
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *leftimage = [[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//导航栏图标
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:leftimage style:UIBarButtonItemStyleDone target:self action:nil];//导航栏的图片
    
    UINavigationBar*nav=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];//这里的高度调整要配合下面的tableheaderview
    [nav setBarTintColor:[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0 ]];//导航栏背景颜色
    [self.view addSubview:nav];
    
    UIButton*fanhui=[[UIButton alloc]initWithFrame:CGRectMake(10, 26, 40, 25)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    fanhui.backgroundColor=[UIColor clearColor];
    [fanhui setAdjustsImageWhenHighlighted:NO];
    [fanhui setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets=UIEdgeInsetsMake(2, 0, 4, 30);
    [nav addSubview:fanhui];
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 28, 200, 18)];
    
    label1.text=@"社团简介";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];
    
    UIScrollView*scr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:scr];
    
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652)];
    UIImage*img1=[UIImage imageNamed:@"231.png"];
    img.contentMode=UIViewContentModeScaleAspectFill;
    img.clipsToBounds=YES;
    [img setImage:img1];
    [scr addSubview:img];
    
    
    UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.width*280/1280+10, 80,80)];
    imageview1.layer.cornerRadius=40;
    imageview1.layer.masksToBounds=YES;
    [imageview1 sd_setImageWithURL:_url];
    
    imageview1.contentMode=UIViewContentModeScaleAspectFill;
    imageview1.backgroundColor=[UIColor grayColor];
    [scr addSubview:imageview1];
    
    UILabel*fenge6=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+50, [UIScreen mainScreen].bounds.size.width, 300)];
    fenge6.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [scr addSubview:fenge6];
    
  
    UILabel*diqu=[[UILabel alloc]initWithFrame:CGRectMake(0, fenge6.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 50)];
    diqu.text=@"  地区";
    diqu.backgroundColor=[UIColor whiteColor];
    [scr addSubview:diqu];
    
    UILabel*diqu1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, fenge6.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 50)];
    diqu1.text=@"四川绵阳";
    diqu1.backgroundColor=[UIColor whiteColor];
    diqu1.textColor=[UIColor blackColor];
    diqu1.font=[UIFont systemFontOfSize:15];
    [scr addSubview:diqu1];

    
        UILabel*fenge1=[[UILabel alloc]initWithFrame:CGRectMake(0,fenge6.frame.origin.y+51, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge1.backgroundColor=[UIColor grayColor];
    [scr addSubview:fenge1];
    
    UILabel*daxue=[[UILabel alloc]initWithFrame:CGRectMake(0, fenge6.frame.origin.y+51.1, [UIScreen mainScreen].bounds.size.width, 50)];
    daxue.text=@"  所在大学";
    
    daxue.backgroundColor=[UIColor whiteColor];
    [scr addSubview:daxue];
    UILabel*daxue1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-98, fenge6.frame.origin.y+51.1, [UIScreen mainScreen].bounds.size.width, 50)];
    daxue1.text=@"西南科技大学";
    daxue1.backgroundColor=[UIColor whiteColor];
    daxue1.textColor=[UIColor blackColor];
    daxue1.font=[UIFont systemFontOfSize:15];
    [scr addSubview:daxue1];

    
    UILabel*fenge2=[[UILabel alloc]initWithFrame:CGRectMake(0,fenge6.frame.origin.y+101.1, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge2.backgroundColor=[UIColor grayColor];
    [scr addSubview:fenge2];
    
    
    
    
    UILabel*fenlei=[[UILabel alloc]initWithFrame:CGRectMake(0, fenge6.frame.origin.y+116.1, [UIScreen mainScreen].bounds.size.width, 50)];
    fenlei.text=@"  分类";
    fenlei.backgroundColor=[UIColor whiteColor];
    [scr addSubview:fenlei];
    UILabel*fenlei1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, fenge6.frame.origin.y+116.1, [UIScreen mainScreen].bounds.size.width, 50)];
    fenlei1.text=_typename;
    fenlei1.backgroundColor=[UIColor whiteColor];
    fenlei1.textColor=[UIColor blackColor];
    fenlei1.font=[UIFont systemFontOfSize:15];
    [scr addSubview:fenlei1];

    
    UILabel*fenge3=[[UILabel alloc]initWithFrame:CGRectMake(0,fenge6.frame.origin.y+166.1, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge3.backgroundColor=[UIColor grayColor];
    [scr addSubview:fenge3];
    
    UILabel*stjj=[[UILabel alloc]initWithFrame:CGRectMake(0, fenge6.frame.origin.y+166.2, [UIScreen mainScreen].bounds.size.width, 50)];
    stjj.text=@"  社团简介";
    stjj.backgroundColor=[UIColor whiteColor];
    [scr addSubview:stjj];

    
    
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, fenge6.frame.origin.y+196.2, [UIScreen mainScreen].bounds.size.width-20, 20)];
    text.text=_jj;
    text.textContainerInset=UIEdgeInsetsMake(1.0f, 4.0f, 10.0f, 4.0f);
    text.textColor=[UIColor grayColor];
    [text setFrame:CGRectMake(0, fenge6.frame.origin.y+216.2, [UIScreen mainScreen].bounds.size.width, text.contentSize.height)];
    [scr addSubview:text];
    
    
}


-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
