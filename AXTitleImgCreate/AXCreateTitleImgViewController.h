//
//  AXCreateTitleImgViewController.h
//  AxProject
//
//  Created by jiangtd on 16/1/11.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AXCreateTitleImgViewControllerBlock)(UIImage *img);

@interface AXCreateTitleImgViewController : UIViewController

@property(nonatomic,copy)AXCreateTitleImgViewControllerBlock block;

@end
