//
//  ViewController.m
//  RichTextDemo
//
//  Created by Victor on 16/10/7.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
@interface ViewController ()<UIWebViewDelegate,
                            UINavigationControllerDelegate,
                            UIImagePickerControllerDelegate>

{
    NSString *_htmlString;//保存输出的富文本
    NSMutableArray *_imageArr;//保存添加的图片
}

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString*wangzhi1;
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic ,strong) NSString *token;
@property (nonatomic ,strong) NSMutableDictionary *dict;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _token=@"51a4fPaAdDpT3Z%2BUEF3yuEqWYvvfk1i1hWcE%2FC%2B8LJBzeP1%2Fd0loqYPDaoy5yrtSTlsWrzRZYxKg2J4d4wWUJeDRiyemZy0JvAJac3a6S4Q9gmVV4A%2F1FTa5q%2FU8Y48T4pvQfJUkRkw04huqRhuYKX%2BJlaPZMayU3ZsXH6Th1gKLe3ckAVUHIwWF8W9Z2Vx2bmYl31iNtVGXt4Tq5JOblfiSS5WWAdNjm4HhXkRkCKP8Vicx7WnsSP%2BodYRTIwnHwEk%2FzYpQuvamERa2bPsZsjStPIzFwgP7bBehzvOt%2FIsx1zxlLlZvjW%2F%2BhcrymFQmHk%2BOxJOktrpVEGaEbqR4hiKRHugltnkL8NvJE85y3%2BkXHDlL5bwk3Rgc6PmGoGTxKmaaqPp0z%2BFG8QX4v6whr%2FG2jBs7z3hEy2iXg8CW51WqasZTIQug2739qg8xFTWe5eOV3711v%2BLFwPd5G55mXsjROK47R7Smmj6mhadmTWnVHAH9It4BoDcih%2FAvYHb2R5BL3agLslYsvqyveGed0TsW66EKkBPVzYuCn70J8tqbEvms9O2PLHiI1tyRC4eGRl7XhGK8J%2BMPcJfAgbAaeTWZUaLa8hdWwViTL1HTR5Pjd8UdDAVQrLPlv4mseiWUYB5u4nVXiCg%2F%2FVvkrvthcXOwpHZIo%2BaPinTCoWmzBa5H2DEXDKKRf3PKLlvoUUlahzNCGQ9MVkiMkbcMn8R1f0Xjru6RTi3IVbbzRVEQPMiIqrkXX58ypl6wgE%2BgJ%2BaV9l45a1M3F5uyIGUz2uuKZYiS4PDtpMMkGcnz7hP3AJSegN%2BEF%2F3ogz620lZ6q1oMiX9ur%2Fqi3s43EcDNn1%2F91eUKhikYA7im1DGKsbfplQ0Y4xxRyKVet7E1ovWlptJJutkVs6gvKeQ2q11Rk4IuNK8p4IdiQ2sq3A514mT7GLnzbMftWj5obIVGxCFeOy0z0L34oWu02f%2Fadsrzuz%2Fybz%2FL%2FjpW%2BYXB96WscYdWVGY4ivydEbpEhlX0OA9CPFQtZ3xs3IEK%2BiofeFrgGncKRz%2F%2BGinB5gbU6HPBV%2Fe4HrsYNzMf9liQSwhsY9LsmCGVtMaiI3WjNmHwb9EyUEU4pLU7h7qlLJkLQ84WXKTCNew6F5eh2Kn0kin0ZDgvRh3AiZuQoBHgLBfdjc4OzITTfRpZn5Kau2LIeWZZGpqIvvKN40Y7SnJhnPjKDDZ04wXHybZHThh1AwDezVoxhUFiql0BM3%2F%2BPdjSHoIUVPTGW7IRG4QuDoQgP8o7kV61";
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本编辑";
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveText)];
    self.navigationItem.rightBarButtonItem = save;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"richTextEditor" withExtension:@"html"];
    
    [self.webView setKeyboardDisplayRequiresUserAction:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 40, 80, 30);
    btn.layer.cornerRadius = 5;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"添加图片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.inHtmlString.length > 0)
    {
        NSString *place = [NSString stringWithFormat:@"window.placeHTMLToEditor('%@')",self.inHtmlString];
        [webView stringByEvaluatingJavaScriptFromString:place];
    }
}


- (void)addImage
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}



- (void)printHTML
{
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title-input').value"];
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    NSString *script = [self.webView stringByEvaluatingJavaScriptFromString:@"window.alertHtml()"];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    NSLog(@"Title: %@", title);
    NSLog(@"Inner HTML: %@", html);
    
    if (html.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
        [alert show];
    }
    else
    {
        
       NSLog(@"234234234%@",[self changeString:html]);
        _htmlString = [self changeString:html];
        NSLog(@"%@",_htmlString);
       
        [self postMessage];
    }
    
}
- (void)postMessage{
_dict = [[NSMutableDictionary alloc]init];
[_dict setObject:self.token forKey:@"token"];
[_dict setObject:@"136" forKey:@"aid"];
[_dict setObject:@"29" forKey:@"taskid"];
[_dict setObject:_htmlString forKey:@"contents"];
    
@try {
    [self.manager POST:@"http://www.jialeshequ.com/user.php?a=basic&f=api_post_submit_task_gain" parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg", [self stringFromDate:now]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:@"public.image"])
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        
        
        //接收类型不一致请替换一致textml或别的
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        
        
        NSString *cookieStr = @"jiale=1";
        [_manager.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        
        
        NSURLSessionDataTask *task = [_manager POST:@"http://www.jialeshequ.com/user.php?a=api&f=addFile" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
            
            
        } progress:^(NSProgress *_Nonnull uploadProgress) {
            //打印下上传进度
            //NSLog(@"3333");
        } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            //上传成功
            //NSLog(@"%@",responseObject);
            NSString*wangzhi=[NSString stringWithFormat:@"%@", [[responseObject objectForKey:@"data"]objectForKey:@"path"]];
            _wangzhi1=[NSString stringWithFormat:@"http://www.jialeshequ.com/%@",wangzhi];
            NSLog(@"%@",_wangzhi1);
            
            NSInteger userid = 12345;
            //对应自己服务器的处理方法,
            //此处是将图片上传ftp中特定位置并使用时间戳命名 该图片地址替换到html文件中去
            //NSString *url = [NSString stringWithFormat:@"http://www.jialeshequ.com/%@",_wangzhi1];
            
            NSString *script = [NSString stringWithFormat:@"window.insertImage('%@', '%@')", _wangzhi1, imagePath];
            NSDictionary *dic = @{@"url":_wangzhi1,@"image":image,@"name":imageName};
            [_imageArr addObject:dic];
            
            [self.webView stringByEvaluatingJavaScriptFromString:script];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
            //上传失败
            //NSLog(@"%@",error);
        }];
        
        
        [imageData writeToFile:imagePath atomically:YES];
    }
    
}



- (void)saveText
{
    [self printHTML];
}


#pragma mark - Method
-(NSString *)changeString:(NSString *)str
{
    
    NSMutableArray * marr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"\""]];
    
    for (int i = 0; i < marr.count; i++)
    {
        NSString * subStr = marr[i];
        if ([subStr hasPrefix:@"/var"] || [subStr hasPrefix:@" id="])
        {
            [marr removeObject:subStr];
            i --;
        }
    }
    NSString * newStr = [marr componentsJoinedByString:@"\""];
    return newStr;
    
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
