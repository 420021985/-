//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "sysViewController.h"
#import "syscell.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "CDPStarEvaluation.h"


//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CDPStarEvaluationDelegate>{
    CDPStarEvaluation *_starEvaluation;//星形评价
    UILabel *_commentLabel;//评论级别label
    
}

@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) UIButton*pingjia;
@property (nonatomic ,strong) UIButton*tiwen;
@property (nonatomic ,strong)sysshang*ceshi;
@property (nonatomic ,strong)UIButton*button;
@property (strong,nonatomic) UITextField*textField;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic ,strong) NSString*token;
@property (nonatomic ,strong) NSString*id;
@property (nonatomic ,strong) NSString*fid;
@property (nonatomic ,strong) UIView*footview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.token=@"6d17w3Fad5O07cjZeeBVrEXY%2Fa0akbnLROHIzDE1av6W38bo9eGKmz56T%2BxThqRnjO90qf9qsDKnpC6d8KeA6Y0Krnma7%2BxEUi9sc%2BnSetWVpz0EvFOyxUuIskLs1I7mSIy5V%2F%2F%2F3KoV3sRCjUcsfkqjm7WYeHjq4cpe%2B6nksMEKKtEWWspE4uNVciENl%2BwIQtBjptDg2MrAXt7B3p0CGdl9pAIdYp9VFvtF20CFtWlgWkl9EvVGmlkWUCVSSwBPv7%2FPHfUbYi0PlNN2UYPk6uOv2rBPObTqwDxzym6kCXqe2sxw8aMaVdIFnhxPdKuCf4VTkdtdeeQ4gswoO3f5LdyV3Pb1Ztx9%2F4sQm4ehv%2BZnm%2BQ4Ada22yX9%2BD83siAkwmLhzOAxsRqoqD8%2F1wLsTociV6XwLfaDJ5CPtksapAXBQ8tsOudXXbV9xYJWEs9aPNSB4zx%2BkIzFyz%2BjJjDsTaZ1Hxrm7kQlataDqlQzu1q7cj%2F0drrBwQohyAyk0nfXpMAYmAQco0hGauGPhlLV6YX65AvfUEGhPHHmTFNoE894YvIycCgw6HTGPQR2RDLr0LJ4sIuaA3m0VYBzueNbi27%2FfJQ5rQO%2BY3pCvsvLyi52KAX8TyPgapegj8VrPrWThPQggojG8yXJL6%2F25M3t%2B83aKib8aaXECvKPnYVRKiQXaYQoimrFr7Avlvwp4KHUl5xsNR9GivQ48UjoDMSfvRV%2Bgsfg9OPWFfh7d5kL4vwkrr1FPBJnfLDDIUTw2HLcMY4QSs5WMG5rgjTkwuUT5wDEyCxHunnTtd%2BbHFdGg50T71KKYkVQVGZse4TklmhRHn7xFOgOE13sSZriplh8hnrOUwCwMSucEvQpH4vFR30KKh1RH3ijMDHkCgpFTtBod1LQjzm35lNtFMcsxz%2FMWftTfvUjRH3TvCVL8u55khda9tschEk6vO4P9lWLERPYEjT3dRECkL9AH%2B%2FKseWcaKz31E6Av7RSEnk%2Bs9qRauUdPJFRUttKlI3JekoibbYKju7QLFneOoqa9lKYbol2CLeCVpu7jiAHM%2BQdELBoqehavBx6hY1lhVyaacd%2FTQ7S8a8kA%2BYWkpBwbl%2FBskRhoEu2%2BX3y2bWeky%2Fi72uh55wUZ1N9B%2Fb9UjmvSdzTby%2Fn2cpwcS4%2ByVyFKnnUn18ZNhIEF7IoIW9mzd97Kksv%2FeXMaPDgxzQ%2FDpKc9sg9ukGcQJ18B%2FC9xqVgBkcY6rgcCbAvMDcuV7dD9bd6YhdObUjgA3K4vUlbWqHd2to%2FsjklOCFYtlK3kSVbI5gyRy8I8tNu";
    self.id=@"56";
    self.fid=@"32";
    
    
    UIImage *leftimage = [[UIImage imageNamed:@"left2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//导航栏图标
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:leftimage style:UIBarButtonItemStyleDone target:self action:nil];//导航栏的图片
    
    UINavigationBar*nav=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];//这里的高度调整要配合下面的tableheaderview
    [nav setBarTintColor:[UIColor whiteColor ]];//导航栏背景颜色
    [self.view addSubview:nav];
    
    UIButton*fanhui=[[UIButton alloc]initWithFrame:CGRectMake(10, 26, 40, 25)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    fanhui.backgroundColor=[UIColor clearColor];
    [fanhui setAdjustsImageWhenHighlighted:NO];
    [fanhui setImage:[UIImage imageNamed:@"left2.png"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets=UIEdgeInsetsMake(2, 0, 4, 20);
    [nav addSubview:fanhui];
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 28, 200, 18)];
    label1.text=@"实验室详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1];
    [nav addSubview:label1];


    
    self.systableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds)-50)];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.systableview setDelegate:self];
    [self.systableview setDataSource: self];
    
    
    
    
    [self.view addSubview:self.systableview];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652, [UIScreen mainScreen].bounds.size.width-20, 300)];
    NSString*id=@"13";
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/sys.php?a=index&f=api_get_sys_info&id=%@",id];//第一个传值92是参数
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSString*content=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"desc"]];
    
    text.text=content;
    text.textColor=[UIColor grayColor];
    text.font=[UIFont systemFontOfSize:10];
    text.editable=NO;
    
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, [UIScreen mainScreen].bounds.size.width*280/640+30, [UIScreen mainScreen].bounds.size.width-20, text.contentSize.height);
    
    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*280/640+30+text.contentSize.height)];
    _systableview.tableHeaderView=_headerview;
    _headerview.backgroundColor=[UIColor whiteColor];
    
     [_headerview addSubview:text];
    
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652)];
    UIImage*img1=[UIImage imageNamed:@"1.png"];
    [img setImage:img1];
    [_headerview addSubview:img];
    
    UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 120, [UIScreen mainScreen].bounds.size.width*280/640-25)];
    NSString*pic1=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"pic"]];
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
    NSArray*result = [regular matchesInString:pic1 options:NSMatchingReportCompletion range:NSMakeRange(0, pic1.length)];
    if(result.count==0){
        url=[NSURL URLWithString:[@"http://www.jialeshequ.com/" stringByAppendingString:pic1]];
    }
    
    [imageview1 sd_setImageWithURL:url];
    
    imageview1.contentMode=UIViewContentModeScaleAspectFill;
    imageview1.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:imageview1];
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 180, 20)];
    NSString*name1=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"name"]];
    name.text=name1;
    [name setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:name];
    
    UILabel*school=[[UILabel alloc]initWithFrame:CGRectMake(140, 30, 120, 10)];
    NSString*school1=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"school"]];
    school.text=school1;
    school.font=[UIFont systemFontOfSize:12];
    [school setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:school];
    
    UILabel*city=[[UILabel alloc]initWithFrame:CGRectMake(140, 50, 120, 10)];
    NSString*xuexiao=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"xuexiao"]];
    city.text=xuexiao;
    city.font=[UIFont systemFontOfSize:12];
    [city setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:city];
    
    UILabel*class=[[UILabel alloc]initWithFrame:CGRectMake(140, 70, 55, 10)];
    class.text=@"评价等级:";
    class.font=[UIFont systemFontOfSize:12];
    [class setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:class];
    
    UILabel*star=[[UILabel alloc]initWithFrame:CGRectMake(195, 70, 20, 10)];
    star.backgroundColor=[UIColor grayColor];
    NSString*num2=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"star"]objectForKey:@"frac" ]];
    NSString*e;
    e=[NSString  stringWithFormat:@"%@分",num2];
    star.text=e;
    star.font=[UIFont systemFontOfSize:12];
    [star setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:star];
    
    
    UILabel*num=[[UILabel alloc]initWithFrame:CGRectMake(140, 110, 120, 30)];
    NSString*num1=[NSString stringWithFormat:@"%@", [[date objectForKey:@"data"]objectForKey:@"click_num"]];
    num.text=num1;
    num.font=[UIFont systemFontOfSize:12];
    [num setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:num];
    
    UILabel*meet=[[UILabel alloc]initWithFrame:CGRectMake(160, 110, 120, 30)];
    meet.text=@"人看过";
    meet.font=[UIFont systemFontOfSize:12];
    [meet setTextColor:[UIColor whiteColor]];
    [imageview1 addSubview:meet];
    
    _pingjia=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20-[UIScreen mainScreen].bounds.size.width*2/5, [UIScreen mainScreen].bounds.size.width*280/640+5, [UIScreen mainScreen].bounds.size.width*2/5, 30)];
    
    
    _pingjia.layer.borderColor=[[UIColor grayColor]CGColor];
    [_pingjia addTarget:self action:@selector(showtext) forControlEvents:UIControlEventTouchUpInside];
    _pingjia.layer.cornerRadius=5;
    _pingjia.layer.borderWidth=0.3;
    _pingjia.layer.masksToBounds = YES;
    _pingjia.font=[UIFont systemFontOfSize:15];
    UIImage*image1=[UIImage imageNamed:@"2.png"];
    UIImageView*image2=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2/16-2, 7, 21, 16)];
    [image2 setImage:image1];
    UILabel*pingjia1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2/16+21, 5, 70, 20)];
    pingjia1.text=@"评价";
    [_headerview addSubview:_pingjia];
    [_pingjia addSubview:image2];
    [_pingjia addSubview:pingjia1];
    
    _tiwen=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+20, [UIScreen mainScreen].bounds.size.width*280/640+5, [UIScreen mainScreen].bounds.size.width*2/5, 30)];
    [_tiwen addTarget:self action:@selector(showtext1) forControlEvents:UIControlEventTouchUpInside];
    _tiwen.layer.borderColor=[[UIColor grayColor]CGColor];
    _tiwen.layer.cornerRadius=5;
    _tiwen.layer.borderWidth=0.3;
    _tiwen.layer.masksToBounds = YES;
    _tiwen.font=[UIFont systemFontOfSize:15];
    UIImage*image3=[UIImage imageNamed:@"3.png"];
    UIImageView*image4=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2/16-2, 7, 21, 16)];
    [image4 setImage:image3];
    UILabel*tiwen2=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2/16+21, 5, 70, 20)];
    tiwen2.text=@"提问";
    [_headerview addSubview:_tiwen];
    [_tiwen addSubview:image4];
    [_tiwen addSubview:tiwen2];
    
  
    
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*280/640+30+text.contentSize.height, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:fenge];
   
    
    
    
    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/sys.php?a=index&f=api_get_sys_comment&id=%@&len=6",id];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[date1 objectForKey:@"data"];
    self._persons=[[NSMutableArray alloc]init];
    self._pj=[[NSMutableArray alloc]init];

    for (NSMutableDictionary*dic in arr){
        sysshang *tmp = [[sysshang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        NSString*title=[dic objectForKeyedSubscript:@"uname"];
        NSString*desc=[dic objectForKeyedSubscript:@"desc"];
        NSString*uid=[dic objectForKeyedSubscript:@"uid"];
        NSString*aid=[dic objectForKeyedSubscript:@"id"];
        tmp.name = title;
        tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
        tmp.aid=aid;
        
        @try {
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
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }

        [self._persons addObject:tmp];//向数组中传解析数据。
        [__pj addObject:desc ];
        
        
        
    }
    
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return _headerview;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"syscell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.syscustomCell = [nib objectAtIndex:0];
        cell = self.syscustomCell;
    }
    sysshang *person = [self._persons objectAtIndex:indexPath.row];
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
    self.systableview.tableFooterView=_footview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.footview addGestureRecognizer:tap];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(3, [UIScreen mainScreen].bounds.size.height-48, [UIScreen mainScreen].bounds.size.width/6*5-6, 40)];
    _textField.layer.cornerRadius=3;
    _textField.layer.masksToBounds=YES;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.delegate=self;
    _textField.textColor=[UIColor grayColor];
    _textField.font=[UIFont systemFontOfSize:12];
    NSString*neirong;
    neirong=@"想对老师说什么";
    _textField.text=neirong;
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

    UILabel *allCommentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-98,self.view.bounds.size.width,self.view.bounds.size.height*0.07042254)];
    
    [self.view addSubview:allCommentLabel];
    
    
    //CDPStarEvaluation星形评价
    _starEvaluation=[[CDPStarEvaluation alloc] initWithFrame:CGRectMake(10,allCommentLabel.frame.origin.y,self.view.bounds.size.width*0.625,allCommentLabel.bounds.size.height) onTheView:self.view];
    _starEvaluation.delegate=self;
    
    //评价级别label
    _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.8+15,allCommentLabel.frame.origin.y,self.view.bounds.size.width*0.2-20,allCommentLabel.bounds.size.height)];
    _commentLabel.text=_starEvaluation.commentText;
    _commentLabel.textColor=[UIColor blueColor];
    _commentLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_commentLabel];

}
-(void)showtext1{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-58, [UIScreen mainScreen].bounds.size.width, 58)];
    label.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80-216)];
    self.systableview.tableFooterView=_footview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.footview addGestureRecognizer:tap];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(3, [UIScreen mainScreen].bounds.size.height-48, [UIScreen mainScreen].bounds.size.width/6*5-6, 40)];
    _textField.layer.cornerRadius=3;
    _textField.layer.masksToBounds=YES;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.delegate=self;
    _textField.textColor=[UIColor grayColor];
    _textField.font=[UIFont systemFontOfSize:12];
    NSString*neirong;
    neirong=@"有什么问题你就问吧";
    _textField.text=neirong;
    _textField.clearsOnBeginEditing=YES;
    [self.view addSubview:_textField];
    
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/6*5+2, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width/6-4, 36)];
    _button.layer.cornerRadius=3;
    _button.layer.masksToBounds=YES;
    [_button addTarget:self action:@selector(submitCommentClick) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(postMessage1) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(reKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(qingkong) forControlEvents:UIControlEventTouchUpInside];
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:_textField];
    [_button setTitle:@"提交" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_button];
    
}

- (void)postMessage {
    NSString*w=[NSString stringWithFormat:@"%f",_starEvaluation.width*5];

    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:w forKey:@"startnum"];
    NSLog(@"%@",w);
    [_dict setObject:_id forKey:@"aid"];
    [_dict setObject:_textField.text forKey:@"desc"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/sys.php?a=index&f=api_post_sys_comment" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
- (void)postMessage1 {
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_textField.text forKey:@"remark"];
    [_dict setObject:_id forKey:@"aid"];
    [_dict setObject:_textField.text forKey:@"title"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/sys.php?a=index&f=api_post_sys_ques" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
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
- (void)reKeyBoard
{
    [_textField resignFirstResponder];
    
    
}
-(void)textChange
{
    if( self.textField.text.length>10){
        _button.userInteractionEnabled=YES;
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        _button.userInteractionEnabled=NO;
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}
-(void)qingkong{
    _textField.text=@"";
}

-(void)shuaxin{
    
    [self._persons removeAllObjects];
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/sys.php?a=index&f=api_get_sys_comment&id=%@&len=6",self.id];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    
    @try {
        
        NSArray*arr=[date1 objectForKey:@"data"];
        self._persons=[[NSMutableArray alloc]init];
        self._pj=[[NSMutableArray alloc]init];
        
        for (NSMutableDictionary*dic in arr){
            sysshang *tmp = [[sysshang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
            NSString*title=[dic objectForKeyedSubscript:@"uname"];
            NSString*desc=[dic objectForKeyedSubscript:@"desc"];
            NSString*uid=[dic objectForKeyedSubscript:@"uid"];
            NSString*aid=[dic objectForKeyedSubscript:@"id"];
            tmp.name = title;
            tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
            tmp.aid=aid;
            
            @try {
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
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            [self._persons addObject:tmp];//向数组中传解析数据。
            [__pj addObject:desc ];
            
            
            
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_systableview reloadData];
    });
    
}
#pragma mark CDPStarEvaluationDelegate获得实时评价级别
-(void)theCurrentCommentText:(NSString *)commentText{
    _commentLabel.text=commentText;
}
#pragma mark 点击事件
//提交评论
-(void)submitCommentClick{
    
}
@end
