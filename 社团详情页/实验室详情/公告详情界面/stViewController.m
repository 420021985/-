//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "stViewController.h"
#import "stcell.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "stjjViewController.h"

#import "SGGenerateQRCodeVC.h"


//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) UIButton*pingjia;
@property (nonatomic ,strong) UIButton*tiwen;
@property (nonatomic ,strong)stshang*ceshi;
@property (nonatomic ,strong)UIButton*button;
@property (strong,nonatomic) UITextField*textField;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic ,strong) NSString*token;
@property (nonatomic ,strong) NSString*id;
@property (nonatomic ,strong) NSString*fid;
@property (nonatomic ,strong) NSString*noteid;
@property (nonatomic ,strong) UIView*footview;
@property (nonatomic ,strong)NSString*content;
@property (nonatomic ,strong)UIButton*button1;
@property (nonatomic ,strong)NSURL*url1;
@property (nonatomic ,strong)NSString*typename;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.token=@"6d17w3Fad5O07cjZeeBVrEXY%2Fa0akbnLROHIzDE1av6W38bo9eGKmz56T%2BxThqRnjO90qf9qsDKnpC6d8KeA6Y0Krnma7%2BxEUi9sc%2BnSetWVpz0EvFOyxUuIskLs1I7mSIy5V%2F%2F%2F3KoV3sRCjUcsfkqjm7WYeHjq4cpe%2B6nksMEKKtEWWspE4uNVciENl%2BwIQtBjptDg2MrAXt7B3p0CGdl9pAIdYp9VFvtF20CFtWlgWkl9EvVGmlkWUCVSSwBPv7%2FPHfUbYi0PlNN2UYPk6uOv2rBPObTqwDxzym6kCXqe2sxw8aMaVdIFnhxPdKuCf4VTkdtdeeQ4gswoO3f5LdyV3Pb1Ztx9%2F4sQm4ehv%2BZnm%2BQ4Ada22yX9%2BD83siAkwmLhzOAxsRqoqD8%2F1wLsTociV6XwLfaDJ5CPtksapAXBQ8tsOudXXbV9xYJWEs9aPNSB4zx%2BkIzFyz%2BjJjDsTaZ1Hxrm7kQlataDqlQzu1q7cj%2F0drrBwQohyAyk0nfXpMAYmAQco0hGauGPhlLV6YX65AvfUEGhPHHmTFNoE894YvIycCgw6HTGPQR2RDLr0LJ4sIuaA3m0VYBzueNbi27%2FfJQ5rQO%2BY3pCvsvLyi52KAX8TyPgapegj8VrPrWThPQggojG8yXJL6%2F25M3t%2B83aKib8aaXECvKPnYVRKiQXaYQoimrFr7Avlvwp4KHUl5xsNR9GivQ48UjoDMSfvRV%2Bgsfg9OPWFfh7d5kL4vwkrr1FPBJnfLDDIUTw2HLcMY4QSs5WMG5rgjTkwuUT5wDEyCxHunnTtd%2BbHFdGg50T71KKYkVQVGZse4TklmhRHn7xFOgOE13sSZriplh8hnrOUwCwMSucEvQpH4vFR30KKh1RH3ijMDHkCgpFTtBod1LQjzm35lNtFMcsxz%2FMWftTfvUjRH3TvCVL8u55khda9tschEk6vO4P9lWLERPYEjT3dRECkL9AH%2B%2FKseWcaKz31E6Av7RSEnk%2Bs9qRauUdPJFRUttKlI3JekoibbYKju7QLFneOoqa9lKYbol2CLeCVpu7jiAHM%2BQdELBoqehavBx6hY1lhVyaacd%2FTQ7S8a8kA%2BYWkpBwbl%2FBskRhoEu2%2BX3y2bWeky%2Fi72uh55wUZ1N9B%2Fb9UjmvSdzTby%2Fn2cpwcS4%2ByVyFKnnUn18ZNhIEF7IoIW9mzd97Kksv%2FeXMaPDgxzQ%2FDpKc9sg9ukGcQJ18B%2FC9xqVgBkcY6rgcCbAvMDcuV7dD9bd6YhdObUjgA3K4vUlbWqHd2to%2FsjklOCFYtlK3kSVbI5gyRy8I8tNu";
    self.id=@"56";
    self.fid=@"32";
    self.noteid=@"110";
    
    
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
    label1.text=@"社团详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1];
    [nav addSubview:label1];
    UIButton*erweima=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-55, 26, 60, 25)];
    [erweima setTitle:@"二维码" forState:UIControlStateNormal];
    [erweima setTitleColor:[UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    erweima.titleLabel.font=[UIFont systemFontOfSize:12];
    [erweima addTarget:self action:@selector(wangzi) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:erweima];

    
    self.sttableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds)-100)];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.sttableview setDelegate:self];
    [self.sttableview setDataSource: self];
    
    
    
    
    [self.view addSubview:self.sttableview];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652, [UIScreen mainScreen].bounds.size.width-20, 300)];
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_list&noteid=%@&token=%@",_noteid,_token];//第一个传值92是参数
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    _content=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"remark"]];
    
    text.text=_content;
    text.textColor=[UIColor whiteColor];
    text.font=[UIFont systemFontOfSize:10];
    text.editable=NO;
    text.backgroundColor=[UIColor clearColor];
    
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, [UIScreen mainScreen].bounds.size.width*280/1280+40, [UIScreen mainScreen].bounds.size.width-20, 20);
    
    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*280/640)];
    _sttableview.tableHeaderView=_headerview;
    _headerview.backgroundColor=[UIColor whiteColor];
    
    
    
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*275/652)];
    UIImage*img1=[UIImage imageNamed:@"231.png"];
    img.contentMode=UIViewContentModeScaleAspectFill;
    img.clipsToBounds=YES;
    [img setImage:img1];
    [_headerview addSubview:img];
    
    [_headerview addSubview:text];
    
    UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.width*280/1280-40, 80,80)];
    imageview1.layer.cornerRadius=40;
    imageview1.layer.masksToBounds=YES;
    
    
    NSString*pic1=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"pic"]];
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
    NSArray*result = [regular matchesInString:pic1 options:NSMatchingReportCompletion range:NSMakeRange(0, pic1.length)];
    if(result.count==0){
        url=[NSURL URLWithString:[@"http://www.jialeshequ.com/" stringByAppendingString:pic1]];
    }
    
    [imageview1 sd_setImageWithURL:url];
    _url1=url;
    imageview1.contentMode=UIViewContentModeScaleAspectFill;
    imageview1.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:imageview1];
    _typename=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"typeName"]];
    
    UIButton*but=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.width*280/1280-40, 80,80)];
    but.backgroundColor=[UIColor clearColor];
    [but addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius=40;
    but.layer.masksToBounds=YES;
    [_headerview addSubview:but];
   
    
    
    
    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_list&noteid=%@&token=%@",_noteid,_token];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
    self._persons=[[NSMutableArray alloc]init];
    self._pj=[[NSMutableArray alloc]init];

    for (NSMutableDictionary*dic in arr){
        stshang *tmp = [[stshang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        NSString*title=[dic objectForKeyedSubscript:@"uname"];
        NSString*desc=[dic objectForKeyedSubscript:@"remark"];
        NSString*uid=[dic objectForKeyedSubscript:@"uid"];
        NSString*aid=[dic objectForKeyedSubscript:@"id"];
        NSString*ctime=[dic objectForKeyedSubscript:@"crtime"];
        NSArray*imgs=[dic objectForKeyedSubscript:@"imgs"];
        NSString*keyword=[dic objectForKeyedSubscript:@"keyword"];
        tmp.name = title;
        
        if([keyword isKindOfClass:[NSNull class]]){
            tmp.keyword =@"nil";
        }else{
            
            tmp.keyword = keyword;
        }
        tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
        tmp.aid=aid;
        
        tmp.number=ctime;
        tmp.nrimg=[imgs firstObject];
        tmp.nrimg2=[imgs lastObject];
        
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
    NSString*a=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"quan"]objectForKey:@"is_menber"]];
    if([a isEqualToString:@"0"]){
        _button1=[[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50)];
        _button1.layer.cornerRadius=3;
        _button1.layer.masksToBounds=YES;
        [_button1 setTitle:@"加入社团" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0];
        [_button1 addTarget:self action:@selector(postMessage) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _button1=[[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width, 50)];
        _button1.layer.cornerRadius=3;
        _button1.layer.masksToBounds=YES;
        [_button1 setTitle:@"退出社团" forState:UIControlStateNormal];
        _button1.backgroundColor=[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0];
        [_button1 addTarget:self action:@selector(postMessage1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:_button1];
}
- (void)postMessage1{
    
    NSLog(@"00000000000");
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_noteid forKey:@"noteid"];
    [_dict setObject:@"我想退出这个社团" forKey:@"msg"];
    [_dict setObject:@"1" forKey:@"is_out"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/note.php?a=api&f=api_post_note_join" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
            [_button1 setTitle:@"加入社团" forState:UIControlStateNormal];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error1111111111111111111111111:%@",error);
        }];
    } @catch (NSException *exception) {
    } @finally {
    }
}
- (void)postMessage{
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_noteid forKey:@"noteid"];
    [_dict setObject:@"我想参加这个活动" forKey:@"msg"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/note.php?a=api&f=api_post_note_join" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_list&noteid=%@&token=%@",_noteid,_token];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
        NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
        self._persons=[[NSMutableArray alloc]init];
        self._pj=[[NSMutableArray alloc]init];
        
        for (NSMutableDictionary*dic in arr){
            stshang *tmp = [[stshang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
            NSString*title=[dic objectForKeyedSubscript:@"uname"];
            NSString*desc=[dic objectForKeyedSubscript:@"remark"];
            NSString*uid=[dic objectForKeyedSubscript:@"uid"];
            NSString*aid=[dic objectForKeyedSubscript:@"id"];
            NSString*ctime=[dic objectForKeyedSubscript:@"crtime"];
            NSArray*imgs=[dic objectForKeyedSubscript:@"imgs"];
            NSString*keyword=[dic objectForKeyedSubscript:@"keyword"];
            tmp.name = title;
            
            if([keyword isKindOfClass:[NSNull class]]){
                tmp.keyword =@"nil";
            }else{
                
                tmp.keyword = keyword;
            }
            tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
            tmp.aid=aid;
            
            tmp.number=ctime;
            tmp.nrimg=[imgs firstObject];
            tmp.nrimg2=[imgs lastObject];
            
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
        [_sttableview reloadData];
    });
    
}

-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - Table view delegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据内容计算高度
    CGRect rect = [__pj[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    //再加上其他控件的高度得到cell的高度
    
    stshang *person = [self._persons objectAtIndex:indexPath.row];
    if(person.speechText.length==0){
        return 165;
    }else{
        if(person.nrimg.length==0){
            
            return rect.size.height + 65;
        }else{
            
            return rect.size.height + 180;
        }
    }
    
    
    
    
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"stcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.stcustomCell = [nib objectAtIndex:0];
        cell = self.stcustomCell;
    }
    stshang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:1];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:3];
    
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    
   
    UILabel *time = (UILabel *)[cell.contentView viewWithTag:6];
    [time setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-81, 13, 71, 10)];
    time.lineBreakMode=NSLineBreakByCharWrapping;
    time.text=person.number;
    UILabel *keyword = (UILabel *)[cell.contentView viewWithTag:7];
    keyword.lineBreakMode=NSLineBreakByCharWrapping;
    keyword.text=person.keyword;
    
    nameLabel.text = person.name;
    text.text = person.speechText;
    text.editable=NO;
    text.scrollEnabled=NO;
    text.font=[UIFont systemFontOfSize:10];
    CGRect rect = [__pj[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    
    
    text.frame=CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, rect.size.height+10);
    if(person.speechText.length==0){
        [text setHidden:YES];
        UIImageView *nrImageView = (UIImageView *)[cell.contentView viewWithTag:4];
        UIImageView *nrImageView1 = (UIImageView *)[cell.contentView viewWithTag:5];
        nrImageView.contentMode=UIViewContentModeScaleAspectFit;
        nrImageView1.contentMode=UIViewContentModeScaleAspectFit;
        if(person.nrimg.length==0){
            [nrImageView setHidden:YES];
            [nrImageView1 setHidden:YES];
        }else if (person.nrimg.length==0){
            
            [nrImageView setFrame:CGRectMake(10, 55, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            nrImageView.backgroundColor=[UIColor greenColor];
            [nrImageView sd_setImageWithURL:person.nrimg];
        }else{
            
            [nrImageView setFrame:CGRectMake(10, 55, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            [nrImageView1 setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+5, 55, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            [nrImageView sd_setImageWithURL:person.nrimg];
            [nrImageView1 sd_setImageWithURL:person.nrimg2];
        }
    }else{
        UIImageView *nrImageView = (UIImageView *)[cell.contentView viewWithTag:4];
        UIImageView *nrImageView1 = (UIImageView *)[cell.contentView viewWithTag:5];
        nrImageView.contentMode=UIViewContentModeScaleAspectFit;
        nrImageView1.contentMode=UIViewContentModeScaleAspectFit;
        if(person.nrimg.length==0){
            [nrImageView setHidden:YES];
            [nrImageView1 setHidden:YES];
        }else if (person.nrimg.length==0){
            
            [nrImageView setFrame:CGRectMake(10, text.frame.origin.y+rect.size.height+10+5, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            [nrImageView sd_setImageWithURL:person.nrimg];
        }else{
            
            [nrImageView setFrame:CGRectMake(10, text.frame.origin.y+rect.size.height+10+5, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            [nrImageView1 setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+5, text.frame.origin.y+rect.size.height+10+5, [UIScreen mainScreen].bounds.size.width/2-15, 100)];
            [nrImageView sd_setImageWithURL:person.nrimg];
            [nrImageView1 sd_setImageWithURL:person.nrimg2];
        }

    }
    
       return cell;
    //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tap{
    
    NSLog(@"%@ %@  %@  %@",_url1,_typename,_noteid,_content);
    stjjViewController*stjj=[[stjjViewController alloc]init];
    stjj.noteid=_noteid;
    stjj.jj=_content;
    stjj.url=_url1;
    stjj.typename=_typename;
    [self presentViewController:stjj animated:YES completion:^{
    }];
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
    NSString*a=[NSString stringWithFormat:@"http://www.jialeshequ.com/user.php?a=apis&f=qrcode&type=shetuanjoin&data={\"shetuanId\":\"%@\"}",_noteid];
    VC.ewmwz=a;
    [self presentViewController:VC animated:YES completion:^{
    }];
}
@end
