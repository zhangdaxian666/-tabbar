//
//  PageControllView.h
//  启示页
//
//  Created by slcf888 on 2017/8/28.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControllView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIPageControl *pageV;

+(PageControllView *)instance;
-(instancetype)initWithFrame:(CGRect)frame andImageList:(NSArray *)arr;
@end
