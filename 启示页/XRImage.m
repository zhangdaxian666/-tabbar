//
//  XRImage.m
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "XRImage.h"

@implementation XRImage

+(instancetype)imageWithImageDic:(NSDictionary *)imageDic
{
    XRImage *image = [[XRImage alloc] init];
    image.imageURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;

}
@end
