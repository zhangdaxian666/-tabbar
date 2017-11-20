//
//  XRCollectionViewCell.m
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "XRCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation XRCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//承于 。h里面的nsurl*imageurl
-(void)setImageURL:(NSURL *)imageURL{
    
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
   
}
@end
