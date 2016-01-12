//
//  AXCreateTitleImgViewController.m
//  AxProject
//
//  Created by jiangtd on 16/1/11.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "AXCreateTitleImgViewController.h"
#import "UIView+addView.h"
#import <CoreImage/CoreImage.h>

#define JGCOLOR(rd,gn,be)  ([UIColor colorWithRed:rd/255.0 green:gn/255.0 blue:be/255.0 alpha:1])

#define ScreenHight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface AXCreateTitleImgViewController ()

@property(nonatomic,weak)UIView *topContentView;
@property(nonatomic,weak)UIView *bottomContentView;

@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,weak)UITextField *textField;

@property(nonatomic,strong)NSMutableArray *fontNameArr;

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSArray *fontNameArray;
@property(nonatomic,strong)NSArray *grandentArr;

@property(nonatomic,assign)CGFloat bottomHight;

@end

@implementation AXCreateTitleImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI
{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(getTitleImg)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.view.backgroundColor = JGCOLOR(200, 200, 200);
    [self getBottomHight];
    [self setupFontAndGrandientArr];
//    [self setupTopView];
    [self setupContentView];
    [self setupBottomView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self registerNotice];
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self removeNotice];
    [super viewDidDisappear:animated];
}

-(void)registerNotice
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardUp:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDown:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:nil];

}

-(void)removeNotice
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)getBottomHight
{
    if (ScreenHight == 480 && ScreenWidth == 320) {
        
    }
}

-(void)setupFontAndGrandientArr
{
     _fontNameArray = @[@"Marker Felt",@"Tamil Sangam MN",@"Tamil Sangam MN",@"Courier New"];
    _grandentArr = @[@[(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor],
                     @[(id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor],
                     @[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor],
                     @[(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor]];
}

-(void)setupContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHight - 44 -300)];
    [self.view addSubview:contentView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [contentView addGestureRecognizer:tapGesture];
    self.topContentView = contentView;
    self.topContentView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"ABC";
    label.frame = [self calculateContextLabelFrameWithTitle:@"ABC"];
    label.center = CGPointMake(contentView.bounds.size.width / 2, contentView.bounds.size.height / 2);
    label.font = [UIFont fontWithName:self.fontNameArray[0] size:25];
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    self.contentLabel = label;
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
    self.gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.gradientLayer.startPoint = CGPointMake(0,0.5);
    self.gradientLayer.endPoint = CGPointMake(1,0.5);
    self.gradientLayer.colors = self.grandentArr[0];
    [contentView.layer addSublayer:self.gradientLayer];
    self.gradientLayer.mask = self.contentLabel.layer;
    self.contentLabel.frame = self.gradientLayer.bounds;
}

-(void)setupBottomView
{
    UIView *bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHight - 300, ScreenWidth, 300)];
    bottomView.backgroundColor = JGCOLOR(222, 222, 222);
    [self.view addSubview:bottomView];
    self.bottomContentView = bottomView;
    
    UIView *textContentView = [[UIView alloc] init];
    textContentView.frame = CGRectMake(0, 0, bottomView.bounds.size.width, 50);
    [bottomView addSubview:textContentView];
    textContentView.backgroundColor = JGCOLOR(55, 44, 16);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.frame = CGRectMake(10, 5, textContentView.bounds.size.width - 20, textContentView.bounds.size.height - 10);
    [textContentView addSubview:textField];
    self.textField = textField;
    
    CGFloat orgY = 60;
    CGFloat orgx = 10;
    CGFloat space = 10;
    CGFloat width = (ScreenWidth - orgx * 2 - 3 * space) / 4;
    CGFloat height = 35;
    
    for (int i = 0; i < 16; i++) {
        UIView *vw = [[UIView alloc] initWithFrame:CGRectMake(orgx + (i % 4) * width + (i % 4) * space, orgY + (i / 4) * height + (i / 4) * space, width, height)];
        vw.backgroundColor = [UIColor clearColor];
        vw.tag = i + 1;
        [self.bottomContentView addSubview:vw];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [vw addGestureRecognizer:tapGesture];
        
        UILabel *label = [[UILabel alloc] initWithFrame:vw.bounds
                          ];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"ABC";
        label.frame = vw.bounds;
        label.font = [UIFont fontWithName:self.fontNameArray[i % 4] size:25];
        label.backgroundColor = [UIColor clearColor];
        [vw addSubview:label];
        
        CAGradientLayer *grandient = [CAGradientLayer layer];
        grandient.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
        grandient.backgroundColor = [UIColor clearColor].CGColor;
        grandient.startPoint = CGPointMake(0,0.5);
        grandient.endPoint = CGPointMake(1,0.5);
        grandient.colors = self.grandentArr[i / 4];
        [vw.layer addSublayer:grandient];
        grandient.mask = label.layer;
        label.frame = grandient.bounds;
    }
}
//
//-(void)setupTopView
//{
//    AXMyScretTopView * topView = [AXMyScretTopView myScretTopView];
//    topView.frame = CGRectMake(0, 0, ScreenWidth, 44);
//    topView.backgroundColor = JGCOLOR(233, 108, 143);
//    topView.titleLabel.text = @"文字图片";
//    topView.sureBtn.hidden = NO;
//    [self.view addSubview:topView];
//    __weak typeof(self) sf = self;
//    topView.block = ^(NSInteger index)
//    {
//        [sf topViewActionWithIndex:index];
//    };
//}

#pragma mark =============Action==============

-(void)reContentLabelFrame
{
    self.contentLabel.frame = [self calculateContextLabelFrameWithTitle:self.contentLabel.text];
    self.contentLabel.center = CGPointMake(self.topContentView.bounds.size.width / 2, self.topContentView.bounds.size.height / 2);
    self.gradientLayer.frame = self.contentLabel.frame;
    
    self.contentLabel.frame = self.gradientLayer.bounds;

}

-(void)viewTap:(UITapGestureRecognizer*)tapGesture
{
    UIView *vw = tapGesture.view;
    NSInteger index = vw.tag - 1;
    
    self.contentLabel.font = [UIFont fontWithName:self.fontNameArray[index % 4] size:25];
    self.gradientLayer.colors = self.grandentArr[index / 4];
    
}

-(void)textFieldTextChange:(NSNotification*)notice
{
    self.contentLabel.text = self.textField.text;
    [self reContentLabelFrame];
}

-(void)keyBoardUp:(NSNotification*)notice
{
    [UIView animateWithDuration:0.5 animations:^{
        self.topContentView.height = self.topContentView.height ;
        self.bottomContentView.height = self.bottomContentView.height ;
        self.bottomContentView.y = self.bottomContentView.y;
    }];
   
}

-(void)keyBoardDown:(NSNotification*)notice
{
    [UIView animateWithDuration:0.5 animations:^{
        self.topContentView.height = self.topContentView.height ;
        self.bottomContentView.height = self.bottomContentView.height ;
        self.bottomContentView.y = self.bottomContentView.y ;
    }];
  
}

-(void)tapGestureAction:(UITapGestureRecognizer*)tapGesture
{
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
}

-(void)topViewActionWithIndex:(NSInteger)index
{
    if(index == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(index == 2)
    {
       [self getTitleImg];
    }
}

-(void)getTitleImg
{
    UIGraphicsBeginImageContext(self.topContentView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [self.topContentView drawViewHierarchyInRect:self.topContentView.frame afterScreenUpdates:YES];
    }
    else
    {
        [self.topContentView.layer renderInContext:context];
    }
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef newImgRef =  CGImageCreateWithImageInRect(img.CGImage, CGRectMake(self.gradientLayer.frame.origin.x, self.gradientLayer.frame.origin.y + 44, self.gradientLayer.frame.size.width, self.gradientLayer.frame.size.height));
    
    UIGraphicsBeginImageContextWithOptions(self.gradientLayer.frame.size, NO, [UIScreen mainScreen].scale);
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.gradientLayer.frame.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawImage(context, CGRectMake(0, 0, self.gradientLayer.frame.size.width, self.gradientLayer.frame.size.height), newImgRef);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
//    UIImageView *ImgView = [[UIImageView alloc] init];
//    ImgView.frame = CGRectMake(50, 90, 300, 200);
//    ImgView.image = newImg;
//    [self.view addSubview:ImgView];
    if (self.block) {
        self.block(newImg);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library toolWriteImageToSavedPhotosAlbum:newImg.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        
//        if (error) {
//            JGLog(@"写入出错");
//        }
//        
//    } groupName:@"爱秀"];
    
}

-(CGRect)calculateContextLabelFrameWithTitle:(NSString*)title
{
    CGFloat width = [title boundingRectWithSize:CGSizeMake(9999999, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size.width;
    if (width <= ScreenWidth - 20) {
        return CGRectMake(0, 0, width, 30);
    }
    width = ScreenWidth - 20;
    CGFloat height = [title boundingRectWithSize:CGSizeMake(width, 999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size.height;
    return CGRectMake(0, 0, width, height);
}

#pragma mark ===============GetMethod==============

-(NSMutableArray*)fontNameArr
{
    if (!_fontNameArr) {
        _fontNameArr = [NSMutableArray array];
    }
    return _fontNameArr;
}

//-(void)test
//{
//    
//    UIImage *orgImg = [UIImage imageNamed:@"testPic"];
//    UIImage *backgroundImage = [UIImage imageNamed:@"tm"];//background"];
//    
//    struct CubeMap myCube = createCubeMap(60, 90);
//    NSData *myData = [[NSData alloc]initWithBytesNoCopy:myCube.data length:myCube.length freeWhenDone:true];
//    CIFilter *colorCubeFilter = [CIFilter filterWithName:@"CIColorCube"];
//    [colorCubeFilter setValue:[NSNumber numberWithFloat:myCube.dimension] forKey:@"inputCubeDimension"];
//    [colorCubeFilter setValue:myData forKey:@"inputCubeData"];
//    [colorCubeFilter setValue:[CIImage imageWithCGImage:orgImg.CGImage] forKey:kCIInputImageKey];
//    
//    CIImage *outputImage = colorCubeFilter.outputImage;
//    CIFilter *sourceOverCompositingFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
//    [sourceOverCompositingFilter setValue:outputImage forKey:kCIInputImageKey];
//    [sourceOverCompositingFilter setValue:[CIImage imageWithCGImage:backgroundImage.CGImage] forKey:kCIInputBackgroundImageKey];
//    
//    outputImage = sourceOverCompositingFilter.outputImage;
//    struct CGImage *cgImage = [[CIContext contextWithOptions: nil]createCGImage:outputImage fromRect:outputImage.extent];
//    
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library toolWriteImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        
//        if (error) {
//            JGLog(@"写入出错");
//        }
//        
//    } groupName:@"爱秀"];
//    
//}

@end















