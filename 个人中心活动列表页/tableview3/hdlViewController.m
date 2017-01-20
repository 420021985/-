//
//  ViewController.m
//  tableview3
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 xkd. All rights reserved.
//



//说明，下面有一个地方可以进行调整，第一个请搜索长度。第二个请搜索导航栏图标，感觉这个图片的大小可以进行一些调整。第三个我在下面取了每个按钮对应的id。担心会和你的第三方库冲突，没有上拉加载功能。标题的字体大小和返回键大小可能需要进行调整。
#import "hdlViewController.h"
#import "hdlcell.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "hdxViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *_persons;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlstring =@"http://www.jialeshequ.com/note.php?a=api&f=api_get_my_act_list&token=eb8foznexpaHaRzcUU4%2B%2FpDcYi7%2Bb%2FMdjwqmWxXwysRoUuexbZxh7DSBrCq65OCbwEEiYuOO0tkbVp1r24QgEv1L3xonNxOwW%2BEn%2FOElfai3drWirxY1tV1XKs71%2F%2Fo%2Fp2yOaVMNnGIBYgIb%2FEMRt5e23OZcP5yn20GFS0611%2F9SPdcY6%2BjpJaLmzfCrTuWhmlZNcfZPn9GGwNN1DiYpWO5blmchEQag73epFqKXgbqQgvYVGQ5eeBCHW6mfak5QTBgb893Hp%2F5aPhBtXNf6UN6vr5lsmMY1oTGknLpB%2Fu6Wv40oGwB4k0uh8Dg%2Fqw4Lkl3nugyhC%2BnJdf9cNJhPDFdPjvFEPoG%2BC3SHXVol%2F%2FIv79m24DwWAiM%2BZSZtZ3qcOnpMAYrea%2Bf7Rn2FAfwGR6O3hbKuSsxTcvRCKRSE0NKJ%2FRoeav5kh7l5nzlbmfY5w%2BI7um3Ir5%2BwJ1%2FP4jVHXKGAJh4HC%2B1fbn3yr3GvNPVNnCqB0QXEGzFgGrZztBPQRsnnaoLJx9t8dQ5%2Fv58BioQhhOb0Bi85kfTkWYr0YnQfSFVgeDMwKoxlr6lDZF4Ay7NBBTLzZO%2Bu5DntPBZOM1Bmv3JNGffJXsTz9Y%2BWcrs5SLwNujQzUhP9%2FxAvGFu%2FcUDAkDqwuNBesFka%2B6PByvXrEgdxZmDT65hn8dO10m152QZoSsd7wf5EI7eDxEgduJOTT4mtCdLa9GbX5BijC275pumOkoIgp7G1sgMLaNPpAsG0Cfu5TANUXowl66PU9Vk8d9MW%2FgKkDpH9TjDhjihe6y4U7p6IHV7xaFnkRSUWxpe6nhBY%2B15RP1plkdWoQD9ekK2yUYJAHmQ1q%2Bw2Y08ga4Nx05lslu5%2FAfULVidNzWOqWpXLfDUrIl7aHOmJiem5N%2F0Osrnw7SI1iEgf3t1%2F4qAYzemCNvn2igI7IUNkF4c6tpFQPU6jpmR%2FiUzIlyLbXcwjBlxFvWoLy1HlLW%2BEu66QCzMsLKFUmwrTIAK%2B5CpN9BbXz1BFR7RxPwIXSanrimAX2HKySv%2FWLBG2pGqZYVopBjFwdEZTs4ElHQwFfG3t5FZ%2FEOudFmi6SeOKVMkxlL9oaSrq10M1wZe5druwvHJC7NhkJkZKqOkRuy4gNWqt5GAcYEX7GttQ5rE%2BCKJXOilC%2BzMVrBtpD09VFPOJ7T9%2BDGmhjS%2BWhKau2eh7GuBWr%2FoBfVWmzVtw02niPbM2SC1ccwL16wHZVg26LYcMIiJL%2BHNvRQ7MAIchGzVcjFTBfbXwz39yDFxv&len=6&group_id=3";//长度，这里面有三个参数可以修改，但是必须有，第一个是group_id,当它等于3的时候是活动，当他等于6的时候是通知，第二个是token，每一个人的不一样。第三个是len我这里还是取的6
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
        NSString*title=[dic objectForKeyedSubscript:@"title"];
        NSString*desc=[dic objectForKeyedSubscript:@"name"];
        NSString*time=[dic objectForKeyedSubscript:@"crtime"];
        NSString*id=[dic objectForKeyedSubscript:@"id"];
        NSString*noteid=[dic objectForKeyedSubscript:@"noteid"];
        NSString*status=[dic objectForKeyedSubscript:@"status"];
        tmp.status=status;
        tmp.number=time;
        tmp.name = desc;
        tmp.speechText = title;//这里对应的是desc不过目前会报错。。。
        tmp.id=id;
        tmp.noteid=noteid;
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
    
    self.hdltableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain] ;
    [self.hdltableview setDelegate:self];
    [self.hdltableview setDataSource: self];
    [self.view addSubview:self.hdltableview];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    hdxViewController*hdx=[[hdxViewController alloc]init];
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hdlTableViewCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.hdlcustomCell = [nib objectAtIndex:0];
        cell = self.hdlcustomCell;
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
