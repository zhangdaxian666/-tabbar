//
//  XRImage.h
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XRImage : NSObject

@property(nonatomic,strong)NSURL *imageURL;
@property(nonatomic,assign)CGFloat imageW;
@property(nonatomic,assign)CGFloat imageH;

+(instancetype)imageWithImageDic:(NSDictionary *)imageDic;
@end
