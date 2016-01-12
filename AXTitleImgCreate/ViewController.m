//
//  ViewController.m
//  AXTitleImgCreate
//
//  Created by jiangtd on 16/1/12.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "ViewController.h"
#import "AXCreateTitleImgViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClicked:(id)sender {
    AXCreateTitleImgViewController *createTitleImgVc = [[AXCreateTitleImgViewController alloc] init];
    __weak typeof(self) sf = self;
    createTitleImgVc.block = ^(UIImage *img)
    {
        [sf createImgDisplayViewWith:img];
    };
    [self.navigationController pushViewController:createTitleImgVc animated:YES];
}

-(void)createImgDisplayViewWith:(UIImage*)img
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, img.size.width, img.size.height)];
    imgView.image = img;
//    imgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imgView];
}

@end

















