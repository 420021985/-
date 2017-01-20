//
//  ViewController+_.m
//  tableview3
//
//  Created by apple on 2017/1/11.
//  Copyright © 2017年 xkd. All rights reserved.
//

#import "znxViewController.h"
#import "znxcell.h"
#import "AFNetworking.h"
#import "JSONKit.h"

@interface znxViewController ()

@property (nonatomic ,strong) NSMutableArray *_persons;
@property (nonatomic ,strong)UITextField*hfbiaoti;
@property (nonatomic ,strong)UITextView*hfneirong;
@property (nonatomic ,strong)UIButton*button;
@property (nonatomic ,strong) NSString*token;
@property (nonatomic ,strong) NSString*id;
@property (nonatomic ,strong) NSString*fid;

@property (nonatomic ,strong) NSMutableDictionary *dict;

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation znxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.token=@"6d17w3Fad5O07cjZeeBVrEXY%2Fa0akbnLROHIzDE1av6W38bo9eGKmz56T%2BxThqRnjO90qf9qsDKnpC6d8KeA6Y0Krnma7%2BxEUi9sc%2BnSetWVpz0EvFOyxUuIskLs1I7mSIy5V%2F%2F%2F3KoV3sRCjUcsfkqjm7WYeHjq4cpe%2B6nksMEKKtEWWspE4uNVciENl%2BwIQtBjptDg2MrAXt7B3p0CGdl9pAIdYp9VFvtF20CFtWlgWkl9EvVGmlkWUCVSSwBPv7%2FPHfUbYi0PlNN2UYPk6uOv2rBPObTqwDxzym6kCXqe2sxw8aMaVdIFnhxPdKuCf4VTkdtdeeQ4gswoO3f5LdyV3Pb1Ztx9%2F4sQm4ehv%2BZnm%2BQ4Ada22yX9%2BD83siAkwmLhzOAxsRqoqD8%2F1wLsTociV6XwLfaDJ5CPtksapAXBQ8tsOudXXbV9xYJWEs9aPNSB4zx%2BkIzFyz%2BjJjDsTaZ1Hxrm7kQlataDqlQzu1q7cj%2F0drrBwQohyAyk0nfXpMAYmAQco0hGauGPhlLV6YX65AvfUEGhPHHmTFNoE894YvIycCgw6HTGPQR2RDLr0LJ4sIuaA3m0VYBzueNbi27%2FfJQ5rQO%2BY3pCvsvLyi52KAX8TyPgapegj8VrPrWThPQggojG8yXJL6%2F25M3t%2B83aKib8aaXECvKPnYVRKiQXaYQoimrFr7Avlvwp4KHUl5xsNR9GivQ48UjoDMSfvRV%2Bgsfg9OPWFfh7d5kL4vwkrr1FPBJnfLDDIUTw2HLcMY4QSs5WMG5rgjTkwuUT5wDEyCxHunnTtd%2BbHFdGg50T71KKYkVQVGZse4TklmhRHn7xFOgOE13sSZriplh8hnrOUwCwMSucEvQpH4vFR30KKh1RH3ijMDHkCgpFTtBod1LQjzm35lNtFMcsxz%2FMWftTfvUjRH3TvCVL8u55khda9tschEk6vO4P9lWLERPYEjT3dRECkL9AH%2B%2FKseWcaKz31E6Av7RSEnk%2Bs9qRauUdPJFRUttKlI3JekoibbYKju7QLFneOoqa9lKYbol2CLeCVpu7jiAHM%2BQdELBoqehavBx6hY1lhVyaacd%2FTQ7S8a8kA%2BYWkpBwbl%2FBskRhoEu2%2BX3y2bWeky%2Fi72uh55wUZ1N9B%2Fb9UjmvSdzTby%2Fn2cpwcS4%2ByVyFKnnUn18ZNhIEF7IoIW9mzd97Kksv%2FeXMaPDgxzQ%2FDpKc9sg9ukGcQJ18B%2FC9xqVgBkcY6rgcCbAvMDcuV7dD9bd6YhdObUjgA3K4vUlbWqHd2to%2FsjklOCFYtlK3kSVbI5gyRy8I8tNu";
    self.id=@"56";
    self.fid=@"32";
        UINavigationBar*nav=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];//这里的高度调整要配合下面的tableheaderview
    [nav setBarTintColor:[UIColor colorWithRed:0 green:153/255.0 blue:204/255.0 alpha:1.0 ]];//导航栏背景颜色
    [self.view addSubview:nav];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton*fanhui=[[UIButton alloc]initWithFrame:CGRectMake(10, 26, 40, 25)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    fanhui.backgroundColor=[UIColor clearColor];
    [fanhui setAdjustsImageWhenHighlighted:NO];
    [fanhui setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets=UIEdgeInsetsMake(2, 0, 4, 30);
    [nav addSubview:fanhui];
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 28, 200, 18)];
    label1.text=@"站内信";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];
    
    UITextView*text=[[UITextView alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.width*275/652+180, [UIScreen mainScreen].bounds.size.width-20, 30)];
    NSString*biaoti;
    biaoti=[NSString stringWithFormat:@"主题:%@",_shuju.speechText];
    text.text=biaoti;
    text.textColor=[UIColor grayColor];
    text.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    text.editable=NO;
    text.alwaysBounceVertical=NO;
    text.frame=CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, text.contentSize.height);
    [self.view addSubview:text];
    UILabel*fenge=[[UILabel alloc]initWithFrame:CGRectMake(0, 50+text.contentSize.height+1, [UIScreen mainScreen].bounds.size.width, 0.1)];
    fenge.backgroundColor=[UIColor grayColor];
    [self.view addSubview:fenge];
    
    NSString*neirong;
    neirong=[NSString stringWithFormat:@"内容详情:%@",_shuju.msg];
    UITextView*text1=[[UITextView alloc]init];
    text1.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    text1.attributedText = [[NSAttributedString alloc]initWithString:text.text attributes:attributes];//解决认为是字符串的问题，。
    text1.text=neirong;
    text1.textColor=[UIColor grayColor];
    text1.editable=NO;
    text1.alwaysBounceVertical=NO;
    text1.frame=CGRectMake(10, 52+text.contentSize.height, [UIScreen mainScreen].bounds.size.width-20, text1.contentSize.height+20);
    [self.view addSubview:text1];
    
    self.view.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    _hfbiaoti=[[UITextField alloc]initWithFrame:CGRectMake(10, 72+text.contentSize.height+text1.contentSize.height, [UIScreen mainScreen].bounds.size.width-20, 40)];
    _hfbiaoti.layer.cornerRadius=3;
    _hfbiaoti.layer.masksToBounds=YES;
    _hfbiaoti.backgroundColor=[UIColor whiteColor];
    _hfbiaoti.delegate=self;
    _hfbiaoti.textColor=[UIColor grayColor];
    _hfbiaoti.font=[UIFont systemFontOfSize:15];
    _hfbiaoti.text=@"标题：";
    _hfbiaoti.clearsOnBeginEditing=YES;
    [self.view addSubview:_hfbiaoti];
    
    _hfneirong=[[UITextView alloc]initWithFrame:CGRectMake(10, 122+text.contentSize.height+text1.contentSize.height, [UIScreen mainScreen].bounds.size.width-20, 100)];
    _hfneirong.layer.cornerRadius=3;
    _hfneirong.layer.masksToBounds=YES;
    _hfneirong.backgroundColor=[UIColor whiteColor];
    _hfneirong.delegate=self;
    _hfneirong.textColor=[UIColor grayColor];
    _hfneirong.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_hfneirong];
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*5/12, 229+text.contentSize.height+text1.contentSize.height, [UIScreen mainScreen].bounds.size.width/6, 36)];
    _button.layer.cornerRadius=3;
    _button.layer.masksToBounds=YES;
    
    [_button addTarget:self action:@selector(postMessage) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(reKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    //[_button addTarget:self action:@selector(qingkong) forControlEvents:UIControlEventTouchUpInside];
    
    [_button setTitle:@"回复" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openkeyBoard) name:UITextViewTextDidBeginEditingNotification object:_hfneirong];//这里是设置了监听事件。
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:_hfbiaoti];
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextViewTextDidChangeNotification object:_hfneirong];
}
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 JMReplyDetailTableViewController *detailReply = [[JMReplyDetailTableViewController alloc]init];
 detailReply.model = self.dataArray[indexPath.row];
 [self.navigationController pushViewController:detailReply animated:YES];
 }*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    int offset=self.view.frame.origin.y+125;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -offset);
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField

{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
}
-(void)openkeyBoard{
    int offset=self.view.frame.origin.y+135;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -offset);
    }];
}
-(void)textChange
{
    if( _hfbiaoti.text.length>1&&_hfneirong.text.length>5){
        _button.userInteractionEnabled=YES;
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        _button.userInteractionEnabled=NO;
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (void)reKeyBoard
{
    [_hfbiaoti resignFirstResponder];
    [_hfneirong resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_hfbiaoti resignFirstResponder];
    [_hfneirong resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];

}
- (void)postMessage {
    
    _dict = [[NSMutableDictionary alloc]init];
    [_dict setObject:self.token forKey:@"token"];
    [_dict setObject:_shuju.uid forKey:@"ids"];//接受人列表
    NSLog(@"%@",_shuju.uid);
    [_dict setObject:_hfbiaoti.text forKey:@"msg"];//消息标题
    [_dict setObject:_hfneirong.text forKey:@"desc"];//消息内容
    [_dict setObject:@"16" forKey:@"tp"];
    @try {
        [self.manager POST:@"http://www.jialeshequ.com/user.php?a=basic&f=api_post_add_user_msg" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"posting");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"这是全部bbs数据%@",jsonStr);
            NSLog(@"222222222222222222 = %@",responseObject);
            
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

@end

