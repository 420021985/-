//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "hfxViewController.h"
#import "hfxcell.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import   "UIImageView+WebCache.h"
#import "AFNetworking.h"



//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface hfxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) NSString*token;
@property (nonatomic ,strong) NSString*aid;
@property (nonatomic ,strong) NSString*fid;
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@property (strong,nonatomic) UITextField*textField;
@property (strong,nonatomic) UIView*footview;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (nonatomic ,strong)hfxshang*ceshi;
@property (nonatomic ,strong)UIButton*button;


@end

@implementation hfxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //post提交
    
    
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
    label1.text=@"回复详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];


    
    self.hfxtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds)-50)];
    //[self setTableview:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ];
    [self.hfxtableview setDelegate:self];
    [self.hfxtableview setDataSource: self];
    self.hfxtableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
   
    
    
    [self.view addSubview:self.hfxtableview];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(55, 50, [UIScreen mainScreen].bounds.size.width-20, 300)];
    
    self.token=@"6d17w3Fad5O07cjZeeBVrEXY%2Fa0akbnLROHIzDE1av6W38bo9eGKmz56T%2BxThqRnjO90qf9qsDKnpC6d8KeA6Y0Krnma7%2BxEUi9sc%2BnSetWVpz0EvFOyxUuIskLs1I7mSIy5V%2F%2F%2F3KoV3sRCjUcsfkqjm7WYeHjq4cpe%2B6nksMEKKtEWWspE4uNVciENl%2BwIQtBjptDg2MrAXt7B3p0CGdl9pAIdYp9VFvtF20CFtWlgWkl9EvVGmlkWUCVSSwBPv7%2FPHfUbYi0PlNN2UYPk6uOv2rBPObTqwDxzym6kCXqe2sxw8aMaVdIFnhxPdKuCf4VTkdtdeeQ4gswoO3f5LdyV3Pb1Ztx9%2F4sQm4ehv%2BZnm%2BQ4Ada22yX9%2BD83siAkwmLhzOAxsRqoqD8%2F1wLsTociV6XwLfaDJ5CPtksapAXBQ8tsOudXXbV9xYJWEs9aPNSB4zx%2BkIzFyz%2BjJjDsTaZ1Hxrm7kQlataDqlQzu1q7cj%2F0drrBwQohyAyk0nfXpMAYmAQco0hGauGPhlLV6YX65AvfUEGhPHHmTFNoE894YvIycCgw6HTGPQR2RDLr0LJ4sIuaA3m0VYBzueNbi27%2FfJQ5rQO%2BY3pCvsvLyi52KAX8TyPgapegj8VrPrWThPQggojG8yXJL6%2F25M3t%2B83aKib8aaXECvKPnYVRKiQXaYQoimrFr7Avlvwp4KHUl5xsNR9GivQ48UjoDMSfvRV%2Bgsfg9OPWFfh7d5kL4vwkrr1FPBJnfLDDIUTw2HLcMY4QSs5WMG5rgjTkwuUT5wDEyCxHunnTtd%2BbHFdGg50T71KKYkVQVGZse4TklmhRHn7xFOgOE13sSZriplh8hnrOUwCwMSucEvQpH4vFR30KKh1RH3ijMDHkCgpFTtBod1LQjzm35lNtFMcsxz%2FMWftTfvUjRH3TvCVL8u55khda9tschEk6vO4P9lWLERPYEjT3dRECkL9AH%2B%2FKseWcaKz31E6Av7RSEnk%2Bs9qRauUdPJFRUttKlI3JekoibbYKju7QLFneOoqa9lKYbol2CLeCVpu7jiAHM%2BQdELBoqehavBx6hY1lhVyaacd%2FTQ7S8a8kA%2BYWkpBwbl%2FBskRhoEu2%2BX3y2bWeky%2Fi72uh55wUZ1N9B%2Fb9UjmvSdzTby%2Fn2cpwcS4%2ByVyFKnnUn18ZNhIEF7IoIW9mzd97Kksv%2FeXMaPDgxzQ%2FDpKc9sg9ukGcQJ18B%2FC9xqVgBkcY6rgcCbAvMDcuV7dD9bd6YhdObUjgA3K4vUlbWqHd2to%2FsjklOCFYtlK3kSVbI5gyRy8I8tNu";
    self.aid=_ya.aid;
    self.fid=_ya.fid;
    NSLog(@"%@  123123 %@",_ya.aid,_ya.fid);
    NSString*p_info=@"1";//需要看一级回复就需要这个参数。
    
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_comment&token=%@&id=%@&p_info=%@&fid=%@",self.token,self.aid,p_info,self.fid];//第一个传值92是参数
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSString*content=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"parent"]objectForKey:@"content"]];
    
    
    text.text=content;
    text.textColor=[UIColor grayColor];
    text.font=[UIFont systemFontOfSize:10];
    text.editable=NO;
    
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(50, 25, [UIScreen mainScreen].bounds.size.width-50, text.contentSize.height);
    
    
    _headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30+text.contentSize.height)];
    _hfxtableview.tableHeaderView=_headerview;
    _headerview.backgroundColor=[UIColor whiteColor];
    
     [_headerview addSubview:text];
    
    
    
    UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    imageview1.layer.cornerRadius=20;
    imageview1.layer.masksToBounds=YES;
    NSString*pic1=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"parent"]objectForKey:@"pic"]];
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
    NSArray*result = [regular matchesInString:pic1 options:NSMatchingReportCompletion range:NSMakeRange(0, pic1.length)];
    if(result.count==0){
        url=[NSURL URLWithString:[@"http://www.jialeshequ.com" stringByAppendingString:pic1]];
        
    }
    NSURL*url2=[NSURL URLWithString:pic1];
    
      [imageview1 sd_setImageWithURL:url2];
    
    imageview1.contentMode=UIViewContentModeScaleAspectFill;
    
    imageview1.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:imageview1];
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 180, 20)];
    NSString*name1=[NSString stringWithFormat:@"%@", [[[date objectForKey:@"data"]objectForKey:@"parent"]objectForKey:@"uname"]];
    name.text=name1;
    name.font=[UIFont systemFontOfSize:12];
    [name setTextColor:[UIColor blackColor]];
    [_headerview addSubview:name];
    
    
  
    
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, 30+text.contentSize.height, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [_headerview addSubview:fenge];
   
    
    
    
    
   
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_comment&token=%@&id=%@&fid=%@",self.token,self.aid,self.fid];//第二个传值的地方，ID是帖子的id，fid是李长根这个一级回复的id。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
    self._persons=[[NSMutableArray alloc]init];
    self._pj=[[NSMutableArray alloc]init];

    for (NSMutableDictionary*dic in arr){
        hfxshang *tmp = [[hfxshang alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"fname"] ;
        NSString*title=[dic objectForKeyedSubscript:@"uname"];
        NSString*desc=[dic objectForKeyedSubscript:@"content"];
        NSString*uid=[dic objectForKeyedSubscript:@"aid"];
        NSString*fid=[dic objectForKeyedSubscript:@"id"];
        NSString*fuid=[dic objectForKeyedSubscript:@"fuid"];
        
        NSString*text1;
        text1=[@" 回复 " stringByAppendingString:pic ];
        NSString*text2;
        text2=[title stringByAppendingString:text1];
        NSString*text3;
        text3=[@" " stringByAppendingString:desc];
        NSString*text4;
        text4=[text2 stringByAppendingString:text3];
        
        tmp.speechText = text4;//这里对应的是desc不过目前会报错。。。
        tmp.fname=pic;
        tmp.aid=uid;
        tmp.fid=fid;
        tmp.fuid=fuid;
        tmp.name=title;
        
        
        [self._persons addObject:tmp];//向数组中传解析数据。
        
        [__pj addObject:text4 ];
        
        
        
    }
        
        
    
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
}
-(void)qingkong{
 _textField.text=@"";
}
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)shuaxin{
    
    [self._persons removeAllObjects];
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_bbs_comment&random=123&token=%@&id=%@&fid=%@",self.token,self.aid,self.fid];//第二个传值的地方，ID是帖子的id，fid是李长根这个一级回复的id。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",jsonstring1);
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
    
         for (NSMutableDictionary*dic in arr){
            hfxshang *tmp = [[hfxshang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"fname"] ;
            NSString*title=[dic objectForKeyedSubscript:@"uname"];
            NSString*desc=[dic objectForKeyedSubscript:@"content"];
            
            NSString*uid=[dic objectForKeyedSubscript:@"aid"];
            NSString*fid=[dic objectForKeyedSubscript:@"id"];
            NSString*fuid=[dic objectForKeyedSubscript:@"fuid"];
            
            NSString*text1;
            text1=[@" 回复 " stringByAppendingString:pic ];
            NSString*text2;
            text2=[title stringByAppendingString:text1];
            NSString*text3;
            text3=[@" " stringByAppendingString:desc];
            NSString*text4;
            text4=[text2 stringByAppendingString:text3];
            
            tmp.speechText = text4;//这里对应的是desc不过目前会报错。。。
            tmp.fname=pic;
            tmp.aid=uid;
            tmp.fid=fid;
            tmp.fuid=fuid;
            tmp.name=title;
            
            [self._persons addObject:tmp];//向数组中传解析数据。
            [__pj addObject:text4 ];
            
            
            
            
        }
        
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_hfxtableview reloadData];
    });
    
}

#pragma mark - Table view delegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据内容计算高度
    CGRect rect = [__pj[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame), MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
    //再加上其他控件的高度得到cell的高度  
    
    return rect.size.height+8;
    
    
    
}
#pragma mark - Table view data source-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSInteger n  = 20;
    return self._persons.count;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return _headerview;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _ceshi=[hfxshang new];
    _ceshi=self._persons[indexPath.row];
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-58, [UIScreen mainScreen].bounds.size.width, 58)];
    label.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80-216)];
    self.hfxtableview.tableFooterView=_footview;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [self.footview addGestureRecognizer:tap];
    
    

    [self.view addSubview:label];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(3, [UIScreen mainScreen].bounds.size.height-48, [UIScreen mainScreen].bounds.size.width/6*5-6, 40)];
    _textField.layer.cornerRadius=3;
    _textField.layer.masksToBounds=YES;
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.delegate=self;
    _textField.textColor=[UIColor grayColor];
    _textField.font=[UIFont systemFontOfSize:12];
    NSString*neirong;
    neirong=[@"回复:" stringByAppendingString:_ceshi.name ];
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
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hfxcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.hfxcustomCell = [nib objectAtIndex:0];
        cell = self.hfxcustomCell;
    }
    hfxshang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:3];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    text.attributedText = [[NSAttributedString alloc]initWithString:text.text attributes:attributes];//解决认为是字符串的问题，。
    
    text.text = (@"%@",person.speechText);
    text.userInteractionEnabled=NO;
    text.editable=NO;
    text.scrollEnabled=NO;
    text.font=[UIFont systemFontOfSize:10];
    text.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, text.frame.size.height-10);
    
    
    return cell;
    //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postMessage {
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_ceshi.fid forKey:@"fid"];
    [_dict setObject:_ceshi.aid forKey:@"aid"];
    [_dict setObject:_textField.text forKey:@"content"];
    [_dict setObject:_ceshi.fuid forKey:@"fuid"];
    [_dict setObject:_ceshi.name forKey:@"fname"];
    @try {
    [self.manager POST:@"http://www.jialeshequ.com/note.php?a=api&f=api_post_note_reply" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"posting");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"这是全部bbs数据%@",jsonStr);
        NSLog(@"222222222222222222 = %@",responseObject);
        [self shuaxin];
        
        
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
@end


