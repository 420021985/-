//
//  ViewController.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "hfViewController.h"
#import "hfcell.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "hfxViewController.h"
#import <UIKit/UIKit.h>
#import "hfxcell.h"
#import "hfxViewController.h"



//需要的参数，请搜索“传值” 取到的id也有大概两个地方。一个是评价，第二个是报名。报名的按钮我目前做不来悬浮，所以我就没有写。

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong) NSMutableArray *_pj;
@property (nonatomic ,strong) NSMutableArray *cjtx;
@property (nonatomic ,strong) NSMutableArray *gaodu;
@property (nonatomic ,strong) UIView*headerview;
@property (nonatomic ,strong) UIButton*pingjia;
@property (nonatomic ,strong) UIButton*tiwen;
@property (nonatomic ,strong)shang*ceshi;
@property (nonatomic ,strong)shang*ceshi1;
@property (nonatomic ,strong)UIButton*button;
@property (strong,nonatomic) UITextField*textField;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic ,strong) NSString*token;
@property (nonatomic ,strong) NSString*id;
@property (nonatomic ,strong) NSString*fid;
@property (nonatomic ,strong) UIView*footview;
@property (nonatomic ,strong) NSString*who;
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
    label1.text=@"回帖";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1];
    [nav addSubview:label1];
    self.hftableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds)-50)];
    [self.hftableview setDelegate:self];
    [self.hftableview setDataSource: self];
    [self.view addSubview:self.hftableview];
    
    NSString*id=@"13";
    
    
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_my_note_msg&token=%@&len=6",_token];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
        NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
        //NSLog(@"%@",urlstring1);
        self._persons=[[NSMutableArray alloc]init];
        self._pj=[[NSMutableArray alloc]init];
        
        for (NSMutableDictionary*dic in arr){
            shang *tmp = [[shang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
            NSString*uname=[dic objectForKeyedSubscript:@"uname"];
            NSString*crtime=[dic objectForKeyedSubscript:@"crtime"];
            NSString*content=[dic objectForKeyedSubscript:@"content"];
            NSArray*imgs1=[dic objectForKeyedSubscript:@"imgs"];
            NSString*postname=[dic objectForKeyedSubscript:@"postname"];
            NSString*title=[dic objectForKeyedSubscript:@"title"];
            NSString*is_reply=[dic objectForKeyedSubscript:@"is_reply"];
            NSString*aid=[dic objectForKeyedSubscript:@"aid"];
            NSString*fid=[dic objectForKeyedSubscript:@"fid"];
            NSString*id=[dic objectForKeyedSubscript:@"id"];
            NSString*uid=[dic objectForKeyedSubscript:@"uid"];
            NSString*name=[dic objectForKeyedSubscript:@"name"];
            tmp.id=id;
            tmp.uid=uid;
            tmp.uname=name;
            tmp.name = uname;
            tmp.aid=aid;
            tmp.fid=fid;
            tmp.speechText = crtime;//这里对应的是desc不过目前会报错。。。
            tmp.content=content;
            tmp.headStr = pic;
            tmp.is_reply=is_reply;
            NSString*a;
            a=[NSString stringWithFormat:@"%@:%@",postname,title];
            tmp.postname=a;
            @try {
                
                
                tmp.imgs = [imgs1 firstObject];
                
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            [self._persons addObject:tmp];//向数组中传解析数据。
            [__pj addObject:content ];
            
            
            
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
    CGRect rect = [__pj[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    //再加上其他控件的高度得到cell的高度  
    
    return rect.size.height + 140;
    
    
    
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hfcell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.hfcustomCell = [nib objectAtIndex:0];
        cell = self.hfcustomCell;
    }
    shang *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:1];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UITextView *text = (UILabel *)[cell.contentView viewWithTag:4];
    UILabel*timelabel=(UILabel *)[cell.contentView viewWithTag:3];
    timelabel.text=person.speechText;
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    nameLabel.text = person.name;
    text.text = person.content;
    text.editable=NO;
    text.scrollEnabled=NO;
    text.font=[UIFont systemFontOfSize:10];
    text.frame=CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, text.frame.size.height);
    UIButton*di=(UIButton *)[cell.contentView viewWithTag:5];
    
    [di setFrame:CGRectMake(80, 50+text.frame.size.height, [UIScreen mainScreen].bounds.size.width-100, 70)];
    di.backgroundColor=[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];
    [di addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headImageView1 = (UIImageView *)[cell.contentView viewWithTag:6];//注意这里的tag值，不能够取0
    [headImageView1 setFrame:CGRectMake(10, 50+text.frame.size.height, 70, 70)];
    [headImageView1 sd_setImageWithURL:person.imgs];
    UILabel*postnamelabel=(UILabel *)[cell.contentView viewWithTag:7];
    [postnamelabel setFrame:CGRectMake(85, 79+text.frame.size.height, [UIScreen mainScreen].bounds.size.width-90, 12)];
    postnamelabel.text=person.postname;
    UIButton*huifu=(UIButton *)[cell.contentView viewWithTag:8];
    [huifu setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, nameLabel.frame.origin.y+3, 30, 14)];
    [huifu addTarget:self action:@selector(showtext) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    _ceshi=__persons[indexPath.row];
    
    
    
    
    return cell;
    //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}
-(void)btnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [self.hftableview indexPathForCell:cell];
   
    
    
    if(_ceshi.is_reply==0){
        //跳转到对应的帖子的界面。
    }else{
        hfxViewController*hfx=[[hfxViewController alloc]init];
        hfxshang*ya=__persons[indexPath.row];
        hfx.ya=ya;
        [self presentViewController:hfx animated:YES completion:^{
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showtext{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-55, [UIScreen mainScreen].bounds.size.width, 55)];
    label.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80-216)];
    self.hftableview.tableFooterView=_footview;
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

    UILabel *allCommentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-98,self.view.bounds.size.width,self.view.bounds.size.height*0.07042254)];
    
    [self.view addSubview:allCommentLabel];
    
    
   

}
- (void)postMessage {
   

    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_ceshi.aid forKey:@"aid"];
    NSLog(@"%@",_ceshi.aid);
    NSLog(@"%@",_ceshi.id);
    NSLog(@"%@",_ceshi.uid);
    NSLog(@"%@",_ceshi.name);
    [_dict setObject:_textField.text forKey:@"content"];
    [_dict setObject:_ceshi.id forKey:@"fid"];
    [_dict setObject:_ceshi.uid forKey:@"fuid"];
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
    if( self.textField.text.length>5){
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
    NSString *urlstring1 =[NSString stringWithFormat:@"http://www.jialeshequ.com/note.php?a=api&f=api_get_my_note_msg&token=%@&len=6",_token];//第二个传值的地方，92是改变的内容。
    NSURL *url1 =[NSURL URLWithString:urlstring1];
    NSString *jsonstring1 = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date1 =[jsonstring1 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
        NSArray*arr=[[date1 objectForKey:@"data"]objectForKey:@"list"];
        //NSLog(@"%@",urlstring1);
        self._persons=[[NSMutableArray alloc]init];
        self._pj=[[NSMutableArray alloc]init];
        
        for (NSMutableDictionary*dic in arr){
            shang *tmp = [[shang alloc] init];
            NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
            NSString*uname=[dic objectForKeyedSubscript:@"uname"];
            NSString*crtime=[dic objectForKeyedSubscript:@"crtime"];
            NSString*content=[dic objectForKeyedSubscript:@"content"];
            NSArray*imgs1=[dic objectForKeyedSubscript:@"imgs"];
            NSString*postname=[dic objectForKeyedSubscript:@"postname"];
            NSString*title=[dic objectForKeyedSubscript:@"title"];
            NSString*is_reply=[dic objectForKeyedSubscript:@"is_reply"];
            NSString*aid=[dic objectForKeyedSubscript:@"aid"];
            NSString*fid=[dic objectForKeyedSubscript:@"fid"];
            NSString*id=[dic objectForKeyedSubscript:@"id"];
            NSString*uid=[dic objectForKeyedSubscript:@"uid"];
            NSString*name=[dic objectForKeyedSubscript:@"name"];
            tmp.id=id;
            tmp.uid=uid;
            tmp.uname=name;
            tmp.name = uname;
            tmp.aid=aid;
            tmp.fid=fid;
            tmp.speechText = crtime;//这里对应的是desc不过目前会报错。。。
            tmp.content=content;
            tmp.headStr = pic;
            tmp.is_reply=is_reply;
            NSString*a;
            a=[NSString stringWithFormat:@"%@:%@",postname,title];
            tmp.postname=a;
            @try {
                
                
                tmp.imgs = [imgs1 firstObject];
                
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            [self._persons addObject:tmp];//向数组中传解析数据。
            [__pj addObject:content ];
            
            
            
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_hftableview reloadData];
    });
    
}

@end
