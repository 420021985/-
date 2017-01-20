//
//  ViewController.m
//  tableview3
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 xkd. All rights reserved.
//



//说明，下面有一个地方可以进行调整，第一个请搜索长度。第二个请搜索导航栏图标，感觉这个图片的大小可以进行一些调整。第三个我在下面取了每个按钮对应的id。担心会和你的第三方库冲突，没有上拉加载功能。标题的字体大小和返回键大小可能需要进行调整。
#import "znxlViewController.h"
#import "znxcell.h"
#import "JSONKit.h"
#import   "UIImageView+WebCache.h"
#import "znxViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *_persons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString*token=@"9c88s5WHV90%2FcLNt9zdqbU%2B%2FweBlRkwE3Hg8trrnMLsRZRYCbvXLpPSiJ4klo4i%2FM1y9zVfqROd64jWce4uCB536n8lh01iHgo4L6S7Xj34MELPS5zKhPuGw7l1c3Qe2AmOEJpupOaknjizHKszIKrDjFiSHegR9ndm2sp1M%2Fq3xcxCF76GgmqiN4veFRMZ%2BSwF3%2B1loHltm0iCD4pT0lK4PJfwozUfCQr0aIkd9uTJAB78NL6AJE8nI%2FAoVTUjn5nBcCcVdQCXZHDtVvg%2FrOCNg1sgHMIIBhEnnXdnnnkPcZFNDQbLEKxAHyN4huNQmqJRlF3HDIhXDgXmYZgsp4NuDYkWx1P6rafWjRUDnmEdO0iFkIoLShfdWQPX39tIDLjBcBRZWL3pa2nmzPMrfc%2BAFuKGR77Cdy1bHBa2osqib%2BNbE50MtAdtZwP0V6gi5ieV4wYFOo5oz9bT1trE7%2B4HjjiRJ%2BzgebNsjZNFFw68Zkn1norzhAtc42FKKoSASYJBpzIFHmsEAiFz4FMP6atwvAXho816OA0%2Blddka0aNWMVg6JAOOM4D8mjgxuZ3K4KQqa4uQMImOuMxacHnupTHxrqCdnDcXMqvdsC1Uq97Z8c2rbjT0zwbEyLqPQ75vwtnzEQlgTSU1R%2BSZ6wXAjk990YX1aTjjI3fKJLC%2FBS%2BuJbWdCtXefv7duCdSKdJmaQksYkVqWZfCE%2FIZnWpL7m99gX7Z6v%2BIvKugguBUtiT%2FDgnCcxC5p1gv%2B5tLp9CdeOS%2FR8ttJ35bzmx5GsK0PTN2WfiyWhSWqUjR%2BjPZ824xFGPVK7TqcqtqPujXpKD03h19K5nKJ149t%2F%2BXr9WK6nmU8VPpL0%2Fn2Ba68vM7gomHA5XytSM1nYNtjkAuaEtVVZIzgmlD%2FoWgg%2FbL%2F6tunWWCY3CoCM%2BM0GhsVc5Pjm2w%2FXR42L7G97J3q0AuJGBBPLnxy2BUyLsSAxUFmcB%2FR07HcArZO4ypwE2IsMGf4%2BEjJTKV8r1xly%2BaeEj7kYtJiBX3EOAarENc4DCko1QxjwTmGVKzi1u5FJcdapCBbLGzhHul8hRHZKF3y8k6KZYp672JzAzFY%2FUo5O1P3flomsR6ymufZWu6bGuJS%2FFJcOU6lalli0KvuvM0%2BXcq8MsjQw90mWxEgM8dDOVRsW4c19IIvfyR2r9c5fmQ6tG6uzpiyQzGzWDFaCaYnPQvry8fA5aBEmAI%2FFsFSHIcHz5sIX6Rhn319mMn0wUe%2FMCbqRdk8PklNGRYG%2Bfe32dOif0Is%2BFxaUdSoTmF0ahYQq1blroA";
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/user.php?a=basic&f=api_get_msg&tp=16&len=6&token=%@&use=no",token];//tp=16表示站内信，use=no表示未读信息。
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",jsonstring);
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
    NSArray*arr=[[date objectForKey:@"data"]objectForKey:@"list"];//一定要取数组。
    
    
    self._persons=[[NSMutableArray alloc]init];
    for (NSMutableDictionary*dic in arr){
        Person *tmp = [[Person alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        NSString*title=[dic objectForKeyedSubscript:@"msg"];
        NSString*desc=[dic objectForKeyedSubscript:@"name"];
        NSString*time=[dic objectForKeyedSubscript:@"crtime"];
        NSString*msg=[dic objectForKeyedSubscript:@"desc"];
        NSString*id=[dic objectForKeyedSubscript:@"uid"];
        tmp.name = desc;
        tmp.number=time;
        tmp.uid=id;
        tmp.msg=msg;
        tmp.speechText = title;//这里对应的是desc不过目前会报错。。。
        
        //图片加载代码
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"http://"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
        NSArray*result = [regular matchesInString:pic options:NSMatchingReportCompletion range:NSMakeRange(0, pic.length)];
        if(result.count==0){
            url=[NSURL URLWithString:[@"http://www.jialeshequ.com" stringByAppendingString:pic]];
        }
        NSURL*url=[NSURL URLWithString:pic];
        
        tmp.headStr = url;
        [self._persons addObject:tmp];//向数组中传解析数据。
    }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
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
    label1.text=@"社团活动列表";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];
    
    [self setTableview:[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain] ];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource: self];
    [self.view addSubview:self.tableview];
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JMReplyDetailTableViewController *detailReply = [[JMReplyDetailTableViewController alloc]init];
    detailReply.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailReply animated:YES];
}*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    znxViewController*hdx=[[znxViewController alloc]init];
    Person*shuju=__persons[indexPath.row];
    hdx.shuju=shuju;
    [self presentViewController:hdx animated:YES completion:^{
    }];
}

#pragma mark - Table view delegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.customCell = [nib objectAtIndex:0];
        cell = self.customCell;
    }
    Person *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:3];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:4];
    timeLabel.text = person.number;
    timeLabel.font=[UIFont systemFontOfSize:12];
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius=20;
    headImageView.contentMode=UIViewContentModeScaleAspectFit;//自适应大小。。。。。。
    nameLabel.text = person.name;
    nameLabel.font=[UIFont systemFontOfSize:12];
    textLabel.text = person.speechText;
    textLabel.font=[UIFont systemFontOfSize:12];
    
    
    return cell;
   //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
