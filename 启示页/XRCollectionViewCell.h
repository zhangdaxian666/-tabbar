//
//  XRCollectionViewCell.h
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) NSURL * imageURL;
@end
