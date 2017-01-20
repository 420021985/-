//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "ggxiangViewController.h"
#import "ggxiang.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import   "UIImageView+WebCache.h"
#import "Person.h"
#import "AFNetworking.h"

#import "CDPStarEvaluation.h"


//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface ggxiangViewController ()<UITableViewDelegate,UITableViewDataSource,CDPStarEvaluationDelegate>{
    CDPStarEvaluation *_starEvaluation;//星形评价
    UILabel *_commentLabel;//评论级别label
    
}

@property (nonatomic, weak) IBOutlet UIView *referencedView;
@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) UILabel*label;
@property (nonatomic ,strong)UIButton*button1;
@property (nonatomic ,strong) NSDictionary*date1;
@property (nonatomic ,strong)NSString*token;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (nonatomic ,strong)UIButton*button;
@property (strong,nonatomic) UITextField*textField;
@property (nonatomic ,strong) UIView*footview;
@property (nonatomic ,strong)UILabel *allCommentLabel;

@property (strong,nonatomic) AFHTTPSessionManager *manager;


@end

@implementation ggxiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _token=@"fcd5lQkSNLxHlgiOPkCXhpYZi6OVwgeR5y20PxbCkqzOHuM3EitnK4YlCdoJOSdJQZ80NGC6AApFj%2BD5D8a6WUyn8xY3g0jEvmQGkNMRuP4uA%2Ba3WLLdEwMz3IA8vbiw32Vq%2BQnihmkS3oevdRKaelMRK2uHqkFHHOyF%2F6ziCnwSnLbhnmrsSU041%2B5fWqt5wKiGk3nPptBTqXE8i7zhGr9cW4J7BHuTzVqiA1TnEW1mwgbxdzSm3nrNP3pa2wMofNXYRx%2B0TPBD2J6FMYG5PpO2O6zNjuKOiX5Mge%2FJ3CH0%2BCu45PCCSN6QNEsPRukqiYGax2ZfshZvwMGpHr%2FLbdW%2BVMK%2FDHNgz03Kw%2BgZkeAukOt53o4cKMLoG1OcWo2DEuzM9raXE2NfBKs4zUT%2FCaSYJb1BAeFlP4SCwKx3obtfooBkNs85DtA%2FsjDr1atDq2lzSPvCw75I33GG8KJkrJUk9gCilmgxpxRO%2BquPE7aIvY040UhABOZNl1UOl3Z7o5ZTzNryP1nrDlYvkKVc5i8L6xeuF%2BYIkxLI4NEkJxbixu1X%2FSn3kRkAnhrQC7ijuUqw2bnLEB3KNkyUGGtvU%2BK%2B11uX1iCoUHALgdHbQ8fSZydj17fAjz00%2BXyi0kWj8bnAh8KdRHKrmGhOOTCfXZakNTaDeykW63VZAxMBDFVFYNXgMo4pmbPMZg%2BomZddYUgYfnYIh1yWtTy5P5OMcdaydRg%2BLqFPx18vies3pHNNv1YRshtH7vgxhZrVNFcaN6VHc%2BJeszJWCRR2k0eOPaFWmPG9cluFDPCyiHY%2BOWkWCgxLYIfQx%2B1%2F9rez0cp7i%2BqBO%2BnrtGk5931RMvE34T70Ykj3TD4utofhYHK4QmLy4rLcGCUOIL3lDohN4nQXJfGMpp6lZnAqsQELtYWX4aKhSKEmfhp3I0G%2FGwCbKylQtEiYYuj8%2F0VCR1I%2F3m90n5esmf%2Fen3ilXuwncQG%2FU%2FnBSokB9%2FsAb%2B67s0S%2FNCZ7mBi5QYzj%2B9hgKuxKm13RofE8O8y2Tn4bP9Mlh3gLENcseVNeA7Y3GH9rrnK3jUKMgyLP0z6dGW1W58FooUslzElr8gkCnjnWan5CX6ea%2Bd7O874KWLyjfX3SANqlrwzVDRAsOP1Oh9kWduNsDalGAIknY7R%2BS4XoF1YQHifsSC%2FNZ4fykOQS6fxwJRlEhZh%2F7pJS6LOUXxBRU2ruBu6L3uTn4zNPAkzDWLYF5YeBfahk6qPlrP7NDkthJHG%2F03hOn2uVlJCUCYDorNBV5IArUnYYofSHgfsJUMpmyYJgvLSb";
    
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/hd.php?a=index&f=api_get_hd_info&id=%@&token=%@",_president.id,_token];//第一个传值92是参数
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    
    _shuju=[[date objectForKey:@"data"]objectForKey:@"uid"];
    
    
    UINavigationBar*nav=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    [nav setBarTintColor:[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0 ]];//导航栏背景颜色
    [self.view addSubview:nav];
    UIButton*fanhui=[[UIButton alloc]initWithFrame:CGRectMake(10, 26, 40, 25)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    fanhui.backgroundColor=[UIColor clearColor];
    [fanhui setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets=UIEdgeInsetsMake(2, 0, 4, 30);
    [nav addSubview:fanhui];
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 28, 200, 18)];
    label1.text=@"活动详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];

    
    self.ggxiangtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.ggxiangtableview setDelegate:self];
    [self.ggxiangtableview setDataSource: self];
    
    
    
    
    [self.view addSubview:self.ggxiangtableview];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+240, [UIScreen mainScreen].bounds.size.width-20, 300)];
    NSString*content=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"content"]];
    text.text=content;
    text.textColor=[UIColor grayColor];
    text.editable=NO;
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+240, [UIScreen mainScreen].bounds.size.width-20, text.contentSize.height);
    

    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652+310+text.contentSize.height)];
    _ggxiangtableview.tableHeaderView=_headerview;
    _headerview.backgroundColor=[UIColor whiteColor];
    
   
    
    
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652)];
    UIImage*img1=[UIImage imageNamed:@"1.png"];
    [img setImage:img1];
    [_headerview addSubview:img];
    
    
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+20, 300, 20)];
    NSString*title=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"title"]];
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
    NSString*uname=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"uname"]];
    faqiren1.text=uname;
    faqiren1.textColor=[UIColor grayColor];
    faqiren1.font=[UIFont systemFontOfSize:12];
    faqiren1.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:faqiren1];
    
    UILabel*time=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+85, 45, 20)];
    time.text=@"时间:";
    time.font=[UIFont systemFontOfSize:15];
    time.textColor=[UIColor grayColor];
    time.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:time];
    
    UILabel*time1=[[UILabel alloc]initWithFrame:CGRectMake(55, [UIScreen mainScreen].bounds.size.width*275/652+85, 300, 20)];
    NSString*stime=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"stime"]];
    time1.text=stime;
    time1.font=[UIFont systemFontOfSize:15];
    time1.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:time1];
    
    
    UILabel*place=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+105, 45, 20)];
    place.text=@"地点:";
    place.font=[UIFont systemFontOfSize:15];
    place.textColor=[UIColor grayColor];
    place.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:place];
    
    
    UILabel*place1=[[UILabel alloc]initWithFrame:CGRectMake(55, [UIScreen mainScreen].bounds.size.width*275/652+105, 300, 20)];
    NSString*adress=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"adress"]];
    place1.text=adress;
    place1.font=[UIFont systemFontOfSize:15];
    place1.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:place1];
    
    
    
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+140, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:fenge];
    
    //发起人头像
    UIImageView*img2=[[UIImageView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
    NSString*upic=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"upic"]];
    //NSLog(@"%@",upic);
        NSURL*url2=[NSURL URLWithString:upic];
        img2.layer.cornerRadius=img2.frame.size.width/2;
        img2.layer.masksToBounds=YES;

        
    
        [img2 sd_setImageWithURL:url2];
    
    [_headerview addSubview:img2];
    
    UILabel*baoming=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.width*275/652+160, 70, 20)];
    baoming.text=@"报名人数:";
    baoming.font=[UIFont systemFontOfSize:14];
    baoming.textColor=[UIColor grayColor];
    baoming.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:baoming];
    
    UILabel*renshu=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, [UIScreen mainScreen].bounds.size.width*275/652+160, 70, 20)];
     @try {
    NSArray*join_num=[[date objectForKey:@"data"]objectForKey:@"members"];
   
    NSUInteger*i=join_num.count;
    NSString*n=[NSString stringWithFormat:@"%i",i];
    renshu.text=n;
    renshu.font=[UIFont systemFontOfSize:14];
    renshu.textColor=[UIColor grayColor];
    renshu.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:renshu];
    
    NSArray*arr2=[[date objectForKey:@"data"]objectForKey:@"members"];
    self.cjtx=[[NSMutableArray alloc]init];
    for (NSMutableDictionary*dic in arr2){
        shang *tmp = [[shang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        
        tmp.headStr = pic;
        [self.cjtx addObject:pic];
    }
    //NSLog(@"%@",self.cjtx);
    if (i==1){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic=_cjtx[0];
        
            NSURL*url2=[NSURL URLWithString:upic];
        
            img.layer.cornerRadius=img.frame.size.width/2;
            img.layer.masksToBounds=YES;
        
                 [img sd_setImageWithURL:url2];
        
        [_headerview addSubview:img];
    }
    else if (i==2){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic=_cjtx[0];
                NSURL*url=[NSURL URLWithString:upic];
      
        img.layer.cornerRadius=img.frame.size.width/2;
        img.layer.masksToBounds=YES;
        [img sd_setImageWithURL:url];
        [_headerview addSubview:img];
        
        UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic1=_cjtx[1];
       
            NSURL*url2=[NSURL URLWithString:upic1];
        
            img1.layer.cornerRadius=img1.frame.size.width/2;
            img1.layer.masksToBounds=YES;

            [img1 sd_setImageWithURL:url2];
        
        [_headerview addSubview:img1];
        
    }else if (i==3){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic=_cjtx[0];
                  NSURL*url=[NSURL URLWithString:upic];
           
            img.layer.cornerRadius=img.frame.size.width/2;
            img.layer.masksToBounds=YES;

        
                [img sd_setImageWithURL:url];
        
        
        [_headerview addSubview:img];
        
        UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic1=_cjtx[1];
      
            NSURL*url2=[NSURL URLWithString:upic1];
        
            img1.layer.cornerRadius=img1.frame.size.width/2;
            img1.layer.masksToBounds=YES;

        
                [img1 sd_setImageWithURL:url2];
        
        
        [_headerview addSubview:img1];
        
        UIImageView*img4=[[UIImageView alloc]initWithFrame:CGRectMake(160, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
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
    
    UILabel*fenge1=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+195, [UIScreen mainScreen].bounds.size.width, 15)];
    fenge1.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [_headerview addSubview:fenge1];
    
    UILabel*jianjie=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+220, 100, 20)];
    
    jianjie.text=@" 活动简介";
    jianjie.font=[UIFont systemFontOfSize:16];
    jianjie.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:jianjie];
    
    
    [_headerview addSubview:text];
    
    UILabel*fenge2=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+260+text.contentSize.height, [UIScreen mainScreen].bounds.size.width, 15)];
    fenge2.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [_headerview addSubview:fenge2];
    
    
    UILabel*pingjia=[[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+285+text.contentSize.height, 100, 20)];
    pingjia.text=@" 校友评价";
    pingjia.font=[UIFont systemFontOfSize:16];
    pingjia.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:pingjia];
    

    
    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/hd.php?a=index&f=api_get_score_list&len=6&id=%@",_president.id];//第二个传值的地方，92是改变的内容。
    
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
        NSString*title=[dic objectForKeyedSubscript:@"name"];
        NSString*desc=[dic objectForKeyedSubscript:@"content"];
        NSString*number=[dic objectForKeyedSubscript:@"num"];
        tmp.number=number;
        tmp.name = title;
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
    }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    NSString*a=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"is_join"]];
    
    _button1=[[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50)];
    _button1.layer.cornerRadius=3;
    _button1.layer.masksToBounds=YES;
    NSLog(@"%@",a);
    
    if([a isEqual:@"0"]){
        [_button1 setTitle:@"待审核" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor grayColor];
        _button1.userInteractionEnabled=NO;
    }else if([a isEqual:@"1"]){
        [_button1 setTitle:@"已报名" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor grayColor];
        _button1.userInteractionEnabled=NO;
        [self.view addSubview:self.button1];
        UILabel*pinglun=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.width*275/652+20, 45, 20)];
        pinglun.text=@"评价";
        UITapGestureRecognizer *uiTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showtext)];
        pinglun.userInteractionEnabled = YES;
        [pinglun addGestureRecognizer:uiTap2];
        pinglun.font=[UIFont systemFontOfSize:15];
        pinglun.textColor=[UIColor colorWithRed:89/255.0 green:146/255.0 blue:255/255.0 alpha:1.0 ];
        pinglun.backgroundColor=[UIColor whiteColor];
        [_headerview addSubview:pinglun];
    }else if([a isEqual:@"2"]){
        [_button1 setTitle:@"报名结束" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor grayColor];
        _button1.userInteractionEnabled=NO;
        [self.view addSubview:self.button1];
        UILabel*pinglun=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.width*275/652+20, 45, 20)];
        pinglun.text=@"评价";
        UITapGestureRecognizer *uiTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showtext)];
        pinglun.userInteractionEnabled = YES;
        [pinglun addGestureRecognizer:uiTap2];
        pinglun.font=[UIFont systemFontOfSize:15];
        pinglun.textColor=[UIColor colorWithRed:89/255.0 green:146/255.0 blue:255/255.0 alpha:1.0 ];
        pinglun.backgroundColor=[UIColor whiteColor];
        [_headerview addSubview:pinglun];
    } else {
        [_button1 setTitle:@"报名" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0];
        [_button1 addTarget:self action:@selector(postMessage1) forControlEvents:UIControlEventTouchUpInside];
        }
    
    [self.view addSubview:_button1];
    
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
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Table view data source-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._persons.count;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return _headerview;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ggxiangcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.ggxiangcustomCell = [nib objectAtIndex:0];
        cell = self.ggxiangcustomCell;
    }
    shang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:1];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel*pllabel=(UILabel *)[cell.contentView viewWithTag:4];
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    nameLabel.text = person.name;
    text.text = person.speechText;
    text.editable=NO;
    text.scrollEnabled=NO;
    text.font=[UIFont systemFontOfSize:10];
    text.frame=CGRectMake(57, 30, [UIScreen mainScreen].bounds.size.width-74, text.frame.size.height);
    
    
    return cell;
    //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showtext{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-100, [UIScreen mainScreen].bounds.size.width, 100)];
    label.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80-216)];
    self.ggxiangtableview.tableFooterView=_footview;
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
    [_button addTarget:self action:@selector(submitCommentClick) forControlEvents:UIControlEventTouchUpInside];
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:_textField];
    [_button setTitle:@"提交" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_button];
    
    _allCommentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-98,self.view.bounds.size.width,self.view.bounds.size.height*0.07042254)];
    
    [self.view addSubview:_allCommentLabel];
    
    
    //CDPStarEvaluation星形评价
    _starEvaluation=[[CDPStarEvaluation alloc] initWithFrame:CGRectMake(10,_allCommentLabel.frame.origin.y,self.view.bounds.size.width*0.625,_allCommentLabel.bounds.size.height) onTheView:self.view];
    _starEvaluation.delegate=self;
    
    //评价级别label
    _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.8+15,_allCommentLabel.frame.origin.y,self.view.bounds.size.width*0.2-20,_allCommentLabel.bounds.size.height)];
    _commentLabel.text=_starEvaluation.commentText;
    _commentLabel.textColor=[UIColor blueColor];
    _commentLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_commentLabel];
    
    

    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    int offset=self.view.frame.origin.y+250;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -offset);
    }];
}

#pragma mark CDPStarEvaluationDelegate获得实时评价级别
-(void)theCurrentCommentText:(NSString *)commentText{
    _commentLabel.text=commentText;
}
#pragma mark 点击事件
//提交评论
-(void)submitCommentClick{
    
}



//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField

{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
}
- (void)postMessage1{
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_president.id forKey:@"aid"];
    [_dict setObject:@"我想参加这个活动" forKey:@"remark"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/hd.php?a=index&f=api_post_join_hd" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
    NSString*w=[NSString stringWithFormat:@"%f",_starEvaluation.width*5];
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_president.id forKey:@"aid"];
    [_dict setObject:_textField.text forKey:@"content"];
    [_dict setObject:_shuju forKey:@"uid"];
    [_dict setObject:@"14" forKey:@"tp"];
    [_dict setObject:w forKey:@"num"];
    NSLog(@"%@",w);
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/user.php?a=basic&f=api_post_add_star_comment" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/hd.php?a=index&f=api_get_score_list&len=6&id=%@",_president.id];//第二个传值的地方，92是改变的内容。
    
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
            NSString*title=[dic objectForKeyedSubscript:@"name"];
            NSString*desc=[dic objectForKeyedSubscript:@"content"];
            NSString*number=[dic objectForKeyedSubscript:@"num"];
            tmp.number=number;
            tmp.name = title;
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
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_ggxiangtableview reloadData];
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


@end
