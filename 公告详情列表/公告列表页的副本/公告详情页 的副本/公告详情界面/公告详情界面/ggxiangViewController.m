//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "ggxiangViewController.h"
#import "ggshang.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"


//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UIView *referencedView;
@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/hd.php?a=index&f=api_get_hd_info&id=92"];//第一个传值92是参数
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    //NSLog(@"%@",date);
    
    UIImage *leftimage = [[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//导航栏图标
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:leftimage style:UIBarButtonItemStyleDone target:self action:nil];//导航栏的图片
    self.navigationItem.leftBarButtonItem=left;
    [self setTitle:@"详情"];//导航栏标题
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0 ]];//导航栏背景颜色
    

    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds))];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource: self];
    
    
    
    
    [self.view addSubview:self.tableview];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+240, [UIScreen mainScreen].bounds.size.width-20, 300)];
    NSString*content=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"content"]];
    text.text=content;
    text.textColor=[UIColor grayColor];
    text.editable=NO;
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+240, [UIScreen mainScreen].bounds.size.width-20, text.contentSize.height);
    

    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652+310+text.contentSize.height)];
    _tableview.tableHeaderView=_headerview;
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
    
    UILabel*pinglun=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.width*275/652+20, 45, 20)];
    pinglun.text=@"评论";
    pinglun.font=[UIFont systemFontOfSize:15];
    pinglun.textColor=[UIColor colorWithRed:89/255.0 green:146/255.0 blue:255/255.0 alpha:1.0 ];
    pinglun.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:pinglun];
    
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*275/652+140, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:fenge];
    
    //发起人头像
    UIImageView*img2=[[UIImageView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
    NSString*upic=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"upic"]];
    //NSLog(@"%@",upic);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL*url2=[NSURL URLWithString:upic];
        NSData*resultdata2=[NSData dataWithContentsOfURL:url2];
        UIImage*img3=[UIImage imageWithData:resultdata2];
        img2.layer.cornerRadius=img2.frame.size.width/2;
        img2.layer.masksToBounds=YES;

        
        dispatch_async(dispatch_get_main_queue(),^{
            [img2 setImage:img3];
        });
    });
    
    [_headerview addSubview:img2];
    
    UILabel*baoming=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.width*275/652+160, 70, 20)];
    baoming.text=@"报名人数:";
    baoming.font=[UIFont systemFontOfSize:14];
    baoming.textColor=[UIColor grayColor];
    baoming.backgroundColor=[UIColor whiteColor];
    [_headerview addSubview:baoming];
    
    UILabel*renshu=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, [UIScreen mainScreen].bounds.size.width*275/652+160, 70, 20)];
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
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL*url2=[NSURL URLWithString:upic];
            NSData*resultdata2=[NSData dataWithContentsOfURL:url2];
            UIImage*img2=[UIImage imageWithData:resultdata2];
            img.layer.cornerRadius=img.frame.size.width/2;
            img.layer.masksToBounds=YES;
            dispatch_async(dispatch_get_main_queue(),^{
                 [img setImage:img2];
            });
        });
        [_headerview addSubview:img];
    }
    else if (i==2){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic=_cjtx[0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
                        dispatch_async(dispatch_get_main_queue(),^{
                            });
        });

        NSURL*url=[NSURL URLWithString:upic];
        NSData*resultdata=[NSData dataWithContentsOfURL:url];
        UIImage*img2=[UIImage imageWithData:resultdata];
        img.layer.cornerRadius=img.frame.size.width/2;
        img.layer.masksToBounds=YES;
        [img setImage:img2];
        [_headerview addSubview:img];
        
        UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic1=_cjtx[1];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL*url2=[NSURL URLWithString:upic1];
            NSData*resultdata2=[NSData dataWithContentsOfURL:url2];
            UIImage*img3=[UIImage imageWithData:resultdata2];
            img1.layer.cornerRadius=img1.frame.size.width/2;
            img1.layer.masksToBounds=YES;

            dispatch_async(dispatch_get_main_queue(),^{
                [img1 setImage:img3];
            });
        });
        
        [_headerview addSubview:img1];
        
    }else if (i==3){
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(60, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic=_cjtx[0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL*url=[NSURL URLWithString:upic];
            NSData*resultdata=[NSData dataWithContentsOfURL:url];
            UIImage*img2=[UIImage imageWithData:resultdata];
            img.layer.cornerRadius=img.frame.size.width/2;
            img.layer.masksToBounds=YES;

            dispatch_async(dispatch_get_main_queue(),^{
                [img setImage:img2];
            });
        });
        
        [_headerview addSubview:img];
        
        UIImageView*img1=[[UIImageView alloc]initWithFrame:CGRectMake(110, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic1=_cjtx[1];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL*url2=[NSURL URLWithString:upic1];
            NSData*resultdata2=[NSData dataWithContentsOfURL:url2];
            UIImage*img3=[UIImage imageWithData:resultdata2];
            img1.layer.cornerRadius=img1.frame.size.width/2;
            img1.layer.masksToBounds=YES;

            dispatch_async(dispatch_get_main_queue(),^{
                [img1 setImage:img3];
            });
        });
        
        [_headerview addSubview:img1];
        
        UIImageView*img4=[[UIImageView alloc]initWithFrame:CGRectMake(160, [UIScreen mainScreen].bounds.size.width*275/652+148, 40, 40)];
        NSString*upic2=_cjtx[2];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL*url3=[NSURL URLWithString:upic2];
            NSData*resultdata3=[NSData dataWithContentsOfURL:url3];
            UIImage*img5=[UIImage imageWithData:resultdata3];
            img4.layer.cornerRadius=img4.frame.size.width/2;
            img4.layer.masksToBounds=YES;
            dispatch_async(dispatch_get_main_queue(),^{
                [img4 setImage:img5];
            });
        });
        
        
        [_headerview addSubview:img4];
    };
    
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
    

    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/hd.php?a=index&f=api_get_score_list&id=92&len=6"];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
    //NSLog(@"%@",arr);
    self._persons=[[NSMutableArray alloc]init];
    self._pj=[[NSMutableArray alloc]init];

    for (NSMutableDictionary*dic in arr){
        shang *tmp = [[shang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        //NSLog(@"%@",pic);
        NSString*title=[dic objectForKeyedSubscript:@"name"];
        NSString*desc=[dic objectForKeyedSubscript:@"content"];
        NSString*uid=[dic objectForKeyedSubscript:@"uid"];
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
        NSData*resultdata=[NSData dataWithContentsOfURL:url];
        tmp.headStr = resultdata;
        [self._persons addObject:tmp];//向数组中传解析数据。
        [__pj addObject:desc ];
        
        
        
    }
    
    
    
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return _headerview;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ggcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
    }
    shang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:1];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel*pllabel=(UILabel *)[cell.contentView viewWithTag:4];
    headImageView.image = [UIImage imageWithData:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    pllabel.text=@"回复";
    pllabel.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 10, 30, 15);
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


@end
