//
//  ViewController.m
//  tableview3
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 xkd. All rights reserved.
//



//说明，下面有一个地方可以进行调整，第一个请搜索长度。第二个请搜索导航栏图标，感觉这个图片的大小可以进行一些调整。第三个我在下面取了每个按钮对应的id。担心会和你的第三方库冲突，没有上拉加载功能。标题的字体大小和返回键大小可能需要进行调整。
#import "gglieViewController.h"
#import "Person.h"
#import "JSONKit.h"
#import "ggxiang.h"
#import "ggxiangViewController.h"
#import   "UIImageView+WebCache.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *_persons;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlstring =[NSString stringWithFormat:@"http://www.jialeshequ.com/user.php?a=basic&f=api_get_hd_list&len=6&modid=99&status=1"];//99表示的是讲座，如果换成14代表的是活动。
    NSURL *url =[NSURL URLWithString:urlstring];
    NSString *jsonstring = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary*date =[jsonstring objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    @try {
       
    NSArray*arr=[[date objectForKey:@"data"]objectForKey:@"list"];//一定要取数组。
    self._persons=[[NSMutableArray alloc]init];
    for (NSMutableDictionary*dic in arr){
        Person *tmp = [[Person alloc] init];
        NSString*pic=[dic objectForKeyedSubscript:@"pic"] ;
        NSString*title=[dic objectForKeyedSubscript:@"title"];
        NSString*desc=[dic objectForKeyedSubscript:@"desc"];
        NSString*click_num=[dic objectForKeyedSubscript:@"click_num"];
        NSString*id=[dic objectForKeyedSubscript:@"id"];
        tmp.name = title;
        tmp.speechText = desc;//这里对应的是desc不过目前会报错。。。
        tmp.number=click_num;
        tmp.id=id;
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
    label1.text=@"活动详情";
    label1.textAlignment=UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:18];
    label1.textColor=[UIColor whiteColor];
    [nav addSubview:label1];

    self.gglietableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain] ;
    [self.gglietableview setDelegate:self];
    [self.gglietableview setDataSource: self];
    [self.view addSubview:self.gglietableview];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ggxiangViewController*ggxiang=[[ggxiangViewController alloc]init];
    Person *president = __persons[indexPath.row];
    ggxiang.president = president;
    [self presentViewController:ggxiang animated:YES completion:^{
    }];
}
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Table view delegate -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"gglieTableViewCell" owner:self options:nil];
    if ([nib count]>0)
    {
        self.ggliecustomCell = [nib objectAtIndex:0];
        cell = self.ggliecustomCell;
    }
    Person *person = [self._persons objectAtIndex:indexPath.row];
    //通过tag值来获取UIImageView和UILabel
    UIImageView *headImageView = (UIImageView *)[cell.contentView viewWithTag:3];//注意这里的tag值，不能够取0
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *numLabel = (UILabel *)[cell.contentView viewWithTag:5];
    UIImageView *chakanImageView = (UIImageView *)[cell.contentView viewWithTag:4];
    chakanImageView.image = [UIImage imageNamed:@"chakan"];
    [headImageView sd_setImageWithURL:person.headStr];
    headImageView.contentMode=UIViewContentModeScaleAspectFill;//自适应大小。。。。。。
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius=10;
    nameLabel.text = person.name;
    nameLabel.font=[UIFont systemFontOfSize:12];
    textLabel.text = person.speechText;
    textLabel.font=[UIFont systemFontOfSize:12];
    numLabel.text = person.number;
    numLabel.font=[UIFont systemFontOfSize:12];
    return cell;
   //为什么这里一直没有把内容进行瘦身，因为这里的数组就在本页进行了定义。如果是进行的全局，定义就好进行刚才说的操作。。。。。。。如果数据来源于外部数组，也好操作。。。。
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
