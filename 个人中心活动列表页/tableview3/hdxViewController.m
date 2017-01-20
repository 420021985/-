//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "hdxViewController.h"
#import "hdxcell.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
#import <Photos/Photos.h>
#import "hfxViewController.h"
#import "hfxcell.h"


//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface hdxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UIView *referencedView;
@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) NSDictionary*date1;
@property (nonatomic ,strong)NSString*token;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (nonatomic ,strong)UIButton*button;
@property (strong,nonatomic) UITextField*textField;
@property (nonatomic ,strong) UIView*footview;
@property (nonatomic ,strong) UILabel*label;
@property (nonatomic ,strong)UIButton*button1;
@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation hdxViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
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
    
    label1.text=@"活动详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];
    
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+180, [UIScreen mainScreen].bounds.size.width-20, 300)];
    
    _token=@"104dBrvAXJ9S6LZ8SdOgwqLXqyI6ZpTWbalADZjjIvTXfzBil6wkcIJoTdj2MC3Wz8Gidr3lQzdCb6RKlU4bPrNBwe8PRVG43ccz1PxqLIQyErfEwsQzmVYQ0HBxY2aw%2Brh%2BAScPI%2BY7n4WiNJgtxvwZnjPU0wT4wx%2FB1EYRpxsWnfikZWSaF%2BJXCHSylV0VLxpi019BRKEGutSgF2%2BelHpZN5ut9xKxenwIT%2FOc4ZxSmErxXGWdRGfc8o3DA0FjvXsZx83zKxhnd8vRvVI%2Fj0II%2Fk%2B1aJ9FpZ4zUCICrvb9piw62HmPDq%2BpsWLx85dsgaZqGMaxkDpiX1%2B2G67icz0pxnXMjTTQrPRbVrXn7IqNpJmLWITt7RcSbHDJ5SJzOK0NmTBsqO%2BWWv7musBct2RdpT%2BGnllBSY4fTJo67WXsXPFTluBqHiyvu%2BdAI6eIOHgR3cfwA1yw15c7NTIjeYZbrK3twczXeWpfPduSMD9pdiN0y%2Fnn%2FXhJgcoCU367mm3vxyR9LPdzNSXUje530hl1bbAKpkFlstwTCekklp1OXpt%2Bi2u0HTMxUw0Rx%2BQdVvLSKxJUCER2iLYNl6M0kkwBCpBot9jF5K6lJg6adLYtsv8KEJNUu712zIhJ1n9Zxg0MNtw8upPZqmtpdy7w6sXbOvo9zyEo6S9lbq15XQNzx2Jpd8ApgS%2B5geLT3pmwZgNvG4%2F4tcc8jCO%2FLDgp%2B1zBWVZmeehSEJB7A9LzFC61UqS%2BSRqXDtAseDZldVfvWpg3teAXttEzl%2BtQia3DDIbQCcqZ9xmBTK%2BgC5s65FKh16NJqaCgKQqJJlzcN3apSYvobL7Jq8miAG92iqBDDKdIS8nrjArVJKbwkKa54uhyfkHO%2FHtNeNZNeG8e%2BeOwytBFMWcilkPnZ3DEzXIUuYTZQ4E5SvHELKbvQvbDTyspwMcIeq4K7iKhB1i97hXAPtodJRK6sY8I10fAUJAajP3MRhO%2Fg5N%2Bjezcg4s8YXeocwvJWCXEx6VQMb5jv6uwYcGIwat33J7QFhb33HfVvlhjrAVU1Gkj9mQcwsJ9jbspXqgBSLOYWrT8nmDL1J4%2BKRHxRVn0jJlnrVLtXHuQURsqlnvqGXoMspqkkLTAjxumjc3CsK1xAy%2F4TFgAgJVUFRbW1UGxM%2BOqnMotbkPY3ywwB0KS7G9y2kkN%2Fc87OPtZFuzY%2BDL57%2B56bELdlVBGec4Xw5%2FGsy1A926k%2FJ3wPuzdW0a526EHWkusFI1sY6eLk2mF62ObPAtK%2Fk2X";
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_info&token=%@&id=359",_token,_shuju.id ];//第一个传值92是参数,参数有帖子id.token。
    NSURL *url =[NSURL URLWithString:urlstring];
    
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSString*content=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"cur"]objectForKey:@"content"]];
    
    text.text=content;
    text.textColor=[UIColor grayColor];
    text.editable=NO;
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+180, [UIScreen mainScreen].bounds.size.width-20, text.contentSize.height);
    
    self.hdxtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-100)];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.hdxtableview setDelegate:self];
    [self.hdxtableview setDataSource: self];
    [self.view addSubview:self.hdxtableview];
    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652+250+text.contentSize.height)];
    _hdxtableview.tableHeaderView=_headerview;
    _headerview.backgroundColor=[UIColor whiteColor];
    
    NSString*adm=[NSString stringWithFormat:@"%@",[[date objectForKey:@"data"]objectForKey:@"cur"]];
    //if([adm isEqualToString:@"true"]){
        UIButton*erweima=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-55, 26, 60, 25)];
        [erweima setTitle:@"签到码" forState:UIControlStateNormal];
        erweima.titleLabel.font=[UIFont systemFontOfSize:12];
        [erweima addTarget:self action:@selector(wangzi) forControlEvents:UIControlEventTouchUpInside];
        [nav addSubview:erweima];
    //}else{
        
    //}
   
    

    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652)];
    UIImage*img1=[UIImage imageNamed:@"1.png"];
    [img setImage:img1];
    [_headerview addSubview:img];
    
    
    
    
    
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+20, 300, 20)];
    NSString*title=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"cur"]objectForKey:@"title"]];
    name.text=title;
    name.font=[UIFont systemFontOfSize:15];
    name.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:name];
    
    UILabel*faqiren=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+45, 55, 20)];
    faqiren.text=@"发起组织:";
    faqiren.textColor=[UIColor grayColor];
    faqiren.font=[UIFont systemFontOfSize:12];
    faqiren.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:faqiren];
    
    UILabel*faqiren1=[[UILabel alloc]initWithFrame:CGRectMake(65, [UIScreen mainScreen].bounds.size.width*275/652+45, 300, 20)];
    NSString*uname=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"name"]];
    faqiren1.text=uname;
    faqiren1.textColor=[UIColor grayColor];
    faqiren1.font=[UIFont systemFontOfSize:12];
    faqiren1.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:faqiren1];
    
    
    UILabel*pinglun=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.width*275/652+20, 45, 20)];
    pinglun.text=@"评论";
    pinglun.font=[UIFont systemFontOfSize:15];
    pinglun.textColor=[UIColor colorWithRed:89/255.0 green:146/255.0 blue:255/255.0 alpha:1.0 ];
    pinglun.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *uiTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showtext)];
    pinglun.userInteractionEnabled = YES;
    [pinglun addGestureRecognizer:uiTap2];
    [_headerview addSubview:pinglun];
    
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+80, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:fenge];
    
    //发起人头像
    UIImageView*img2=[[UIImageView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
    
    //NSLog(@"%@",upic);
   
        NSString*pic=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"pic"]];
        NSURL*url2=[NSURL URLWithString:pic];
        img2.layer.cornerRadius=img2.frame.size.width/2;
        img2.layer.masksToBounds=YES;
        [img2 sd_setImageWithURL:url2];
       
    [_headerview addSubview:img2];
    
    UILabel*baoming=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.width*275/652+100, 70, 20)];
    baoming.text=@"报名人数:";
    baoming.font=[UIFont systemFontOfSize:14];
    baoming.textColor=[UIColor grayColor];
    baoming.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:baoming];
    
    UILabel*renshu=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, [UIScreen mainScreen].bounds.size.width*275/652+100, 70, 20)];
    @try {
    NSArray*join_num1=[[date objectForKey:@"data"]objectForKey:@"hd_list2"];
    NSArray*join_num2=[[date objectForKey:@"data"]objectForKey:@"hd_list"];
    
      
    NSUInteger*i=join_num1.count+join_num2.count;
    NSString*n=[NSString stringWithFormat:@"%i",i];
    renshu.text=n;
    renshu.font=[UIFont systemFontOfSize:14];
    renshu.textColor=[UIColor grayColor];
    renshu.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:renshu];
    
    NSArray*arr2=[[date objectForKey:@"data"]objectForKey:@"hd_list"];
    self.cjtx=[[NSMutableArray alloc]init];
    for (NSMutableDictionary*dic in arr2){
        shang *tmp = [[shang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        
        tmp.headStr = pic;
        [self.cjtx addObject:pic];
    }
    //NSLog(@"%@",self.cjtx);
    if (i==1){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
        NSString*upic=_cjtx[0];
        //NSLog(@"%@",upic);
      
            NSURL*url2=[NSURL URLWithString:upic];
            img.layer.cornerRadius=img.frame.size.width/2;
            img.layer.masksToBounds=YES;
                   [img sd_setImageWithURL:url2];
       
        
        [_headerview addSubview:img];
    }
       else if (i==2){
           UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
           NSString*upic=_cjtx[0];
                  NSURL*url=[NSURL URLWithString:upic];
        
               img.layer.cornerRadius=img.frame.size.width/2;
               img.layer.masksToBounds=YES;
                    [img sd_setImageWithURL:img2];
                 [_headerview addSubview:url];
           
           UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
           NSString*upic1=_cjtx[1];
       
               NSURL*url2=[NSURL URLWithString:upic1];
            img1.layer.cornerRadius=img1.frame.size.width/2;
               img1.layer.masksToBounds=YES;
          
                   [img1 sd_setImageWithURL:url2];
                        [_headerview addSubview:img1];
        
       }else if (i==3){
           UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
           NSString*upic=_cjtx[0];
               NSURL*url=[NSURL URLWithString:upic];
           
               img.layer.cornerRadius=img.frame.size.width/2;
               img.layer.masksToBounds=YES;
                [img sd_setImageWithURL:img2];
           
           [_headerview addSubview:url];
           
           UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
           NSString*upic1=_cjtx[1];
               NSURL*url2=[NSURL URLWithString:upic1];
           
               img1.layer.cornerRadius=img1.frame.size.width/2;
               img1.layer.masksToBounds=YES;
           
                   [img1 sd_setImageWithURL:url2];
           
           [_headerview addSubview:img1];
           
           UIImageView*img4=[[UIImageView alloc]initWithFrame:CGRectMake(160, [UIScreen mainScreen].bounds.size.width*275/652+88, 40, 40)];
           NSString*upic2=_cjtx[2];
         
               NSURL*url3=[NSURL URLWithString:upic2];
               img4.layer.cornerRadius=img4.frame.size.width/2;
               img4.layer.masksToBounds=YES;

                            [img4 sd_setImageWithURL:url3];
          

           [_headerview addSubview:img4];
       };
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    UILabel*fenge1=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+135, [UIScreen mainScreen].bounds.size.width, 15)];
    fenge1.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [_headerview addSubview:fenge1];
    
    UILabel*jianjie=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+160, 100, 20)];
    
    jianjie.text=@" 活动简介";
    jianjie.font=[UIFont systemFontOfSize:16];
    jianjie.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:jianjie];
    
    [_headerview addSubview:text];
    
    UILabel*fenge2=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+200+text.contentSize.height, [UIScreen mainScreen].bounds.size.width, 15)];
    fenge2.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [_headerview addSubview:fenge2];
    
    
    UILabel*pingjia=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+225+text.contentSize.height, 100, 20)];
    pingjia.text=@" 校友评价";
    pingjia.font=[UIFont systemFontOfSize:16];
    pingjia.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:pingjia];
    
    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_comment&id=%@&token=%@&len=6",_shuju.id,_token];//第二个传值的地方，len是取得评论的条数，id是帖子的id，token是登录用户的。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
    self._persons=[[NSMutableArray alloc]init];
    self._pj=[[NSMutableArray alloc]init];
    for (NSMutableDictionary*dic in arr){
        shang *tmp = [[shang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        //NSLog(@"%@",pic);
        NSString*title=[dic objectForKeyedSubscript:@"uname"];
        NSString*desc=[dic objectForKeyedSubscript:@"content"];
        NSString*uid=[dic objectForKeyedSubscript:@"uid"];
        NSString*aid=[dic objectForKeyedSubscript:@"aid"];
        NSString*fid=[dic objectForKeyedSubscript:@"id"];
        tmp.name = title;
        tmp.aid=aid;
        tmp.fid=fid;
        tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
        
        
        //图片加载代码
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
        NSArray*result = [regular matchesInString:pic options:NSMatchingReportCompletion range:NSMakeRange(0, pic.length)];
        if(result.count==0){
            url1=[NSURL URLWithString:[@"http://www.jialeshequ.com" stringByAppendingString:pic]];
        }
        
        NSURL*url=[NSURL URLWithString:pic];
        tmp.headStr = url;
        [self._persons addObject:tmp];//向数组中传解析数据。
        [__pj addObject:desc ];
        //NSLog(@"%@",__pj);
        
    }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    _button1=[[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50)];
    _button1.layer.cornerRadius=3;
    _button1.layer.masksToBounds=YES;
    //NSLog(@"%@",_shuju.status);
    if([_shuju.status isEqual:@"1"]){
        [_button1 setTitle:@"已通过" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor grayColor];
        _button1.userInteractionEnabled=NO;
    }else if([_shuju.status isEqual:@"0"]){
        [_button1 setTitle:@"报名" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0];
        [_button1 addTarget:self action:@selector(postMessage1) forControlEvents:UIControlEventTouchUpInside];
    }else if([_shuju.status isEqual:@"2"]){
        [_button1 setTitle:@"人数已满" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor grayColor];
        _button1.userInteractionEnabled=NO;
    }
    
    [self.view addSubview:self.button1];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _headerview;
}
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - Table view delegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据内容计算高度
    CGRect rect = [__pj[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-74, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    //再加上其他控件的高度得到cell的高度  
    
    return rect.size.height + 50;
    
}
#pragma mark - Table view data source-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self._persons.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hdxcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.hdxcustomCell = [nib objectAtIndex:0];
        cell = self.hdxcustomCell;
    }
    shang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:1];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:3];
    UIButton*plbutton=(UIButton *)[cell.contentView viewWithTag:4];
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    nameLabel.text = person.name;
    plbutton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 10, 30, 15);
    [plbutton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    text.text = person.speechText;
    text.editable=NO;
    text.scrollEnabled=NO;
    text.font=[UIFont systemFontOfSize:10];
    text.frame=CGRectMake(57, 30, [UIScreen mainScreen].bounds.size.width-74, text.frame.size.height);
    
    
    return cell;
    //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}
-(void)btnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [self.hdxtableview indexPathForCell:cell];
    
    
    
    
        hfxViewController*hfx=[[hfxViewController alloc]init];
        hfxshang*ya=__persons[indexPath.row];
        hfx.ya=ya;
        [self presentViewController:hfx animated:YES completion:^{
        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showtext{
    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-58, [UIScreen mainScreen].bounds.size.width, 58)];
    _label.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    [self.view addSubview:_label];
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80-216)];
    self.hdxtableview.tableFooterView=_footview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.footview addGestureRecognizer:tap];
    
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(3, [UIScreen mainScreen].bounds.size.height-48, [UIScreen mainScreen].bounds.size.width/6*5-6, 40)];
    _textField.layer.cornerRadius=3;
    _textField.layer.masksToBounds=YES;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.delegate=self;
    _textField.textColor=[UIColor grayColor];
    _textField.font=[UIFont systemFontOfSize:12];
    _textField.clearsOnBeginEditing=YES;
    [self.view addSubview:_textField];
    
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/6*5+2, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width/6-4, 36)];
    _button.layer.cornerRadius=3;
    _button.layer.masksToBounds=YES;
    [_button addTarget:self action:@selector(postMessage) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(reKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(qingkong) forControlEvents:UIControlEventTouchUpInside];
    
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:_textField];
    [_button setTitle:@"提交" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_button];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    int offset=self.view.frame.origin.y+250;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -offset);
    }];
}





//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField

{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
}


-(void)textChange
{
    if( self.textField.text.length>5){
        _button.userInteractionEnabled=YES;
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        _button.userInteractionEnabled=NO;
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}
- (void)postMessage{
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_shuju.id forKey:@"aid"];
    [_dict setObject:_textField.text forKey:@"content"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/note.php?a=api&f=api_post_note_reply" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"posting");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"这是全部bbs数据%@",jsonStr);
            NSLog(@"222222222222222222 = %@",responseObject);
            [self shuaxin];
            NSDictionary*date =[jsonStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            NSString*msg=[date objectForKey:@"msg"];
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error1111111111111111111111111:%@",error);
        }];
    } @catch (NSException *exception) {
    } @finally {
    }
}
- (void)postMessage1{
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_shuju.id forKey:@"aid"];
    [_dict setObject:_shuju.noteid forKey:@"noteid"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/note.php?a=api&f=api_post_join_activity" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"posting");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"这是全部bbs数据%@",jsonStr);
            NSLog(@"222222222222222222 = %@",responseObject);
            [self shuaxin];
            NSDictionary*date =[jsonStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            NSString*msg=[date objectForKey:@"msg"];
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error1111111111111111111111111:%@",error);
        }];
    } @catch (NSException *exception) {
    } @finally {
    }
}

-(void)shuaxin{
    
    [self._persons removeAllObjects];
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_comment&id=%@&token=%@&len=6",_shuju.id,_token];//第二个传值的地方，len是取得评论的条数，id是帖子的id，token是登录用户的。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
        self._persons=[[NSMutableArray alloc]init];
        self._pj=[[NSMutableArray alloc]init];
        for (NSMutableDictionary*dic in arr){
            shang *tmp = [[shang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
            //NSLog(@"%@",pic);
            NSString*title=[dic objectForKeyedSubscript:@"uname"];
            NSString*desc=[dic objectForKeyedSubscript:@"content"];
            NSString*uid=[dic objectForKeyedSubscript:@"uid"];
            NSString*aid=[dic objectForKeyedSubscript:@"aid"];
            NSString*fid=[dic objectForKeyedSubscript:@"id"];
            tmp.name = title;
            tmp.aid=aid;
            tmp.fid=fid;
            tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
            
            
            //图片加载代码
            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:nil];
            NSArray*result = [regular matchesInString:pic options:NSMatchingReportCompletion range:NSMakeRange(0, pic.length)];
            if(result.count==0){
                url1=[NSURL URLWithString:[@"http://www.jialeshequ.com" stringByAppendingString:pic]];
            }
            
            NSURL*url=[NSURL URLWithString:pic];
            tmp.headStr = url;
            [self._persons addObject:tmp];//向数组中传解析数据。
            [__pj addObject:desc ];
            //NSLog(@"%@",__pj);
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }


    dispatch_async(dispatch_get_main_queue(), ^{
        [_hdxtableview reloadData];
    });
    
}
-(void)qingkong{
    _textField.text=@"";
}
- (void)reKeyBoard
{
    [_textField resignFirstResponder];
    
    
}
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}
-(void)wangzi{
    SGGenerateQRCodeVC *VC = [[SGGenerateQRCodeVC alloc] init];
    NSString*a=[NSString stringWithFormat:@"http://www.jialeshequ.com/user.php?a=apis&f=qrcode&type=huodongqiandao&data={\"huodongUid\":\"%@\"}",_shuju.id];
    VC.ewmwz=a;
    [self presentViewController:VC animated:YES completion:^{
    }];
}
@end
