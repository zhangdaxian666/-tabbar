//
//  PageControllView.m
//  启示页

//UIViewContentModeScaleAspectFill, // 这是整个view会被图片填满，图片比例不变
//IViewContentModeScaleAspectFit, //比例不变 如果图片和view的比例不一样 就会有留白

//  Created by slcf888 on 2017/8/28.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "PageControllView.h"
#import "PageCollectionViewCell.h"
#define  kHighlighted [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define kAfterDelayTime 0.3 //最后按钮显示的延迟时间
static NSString *reuseIdentifier = @"PageCollectionViewCell";

@interface PageControllView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)NSArray*imageArr;
@end

@implementation PageControllView

+(PageControllView *)instance
{
    NSArray*nibView=[[NSBundle mainBundle]loadNibNamed:@"PageControllView" owner:self options:nil];
    return [nibView objectAtIndex:0];
}
-(instancetype)initWithFrame:(CGRect)frame andImageList:(NSArray *)arr
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.backgroundColor=[UIColor brownColor];
        
        self.imageArr=arr;
        
        [self setViews];
    }
    return self;
}
-(void)setViews
{
    self.collectionV.frame=self.frame;
    self.collectionV.dataSource=self;
    self.collectionV.delegate=self;
    self.collectionV.pagingEnabled=YES;
    self.collectionV.bounces=NO;
    self.collectionV.showsVerticalScrollIndicator=NO;
    self.collectionV.showsHorizontalScrollIndicator=NO;

    [self.collectionV registerClass:[PageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //页面pag数
    self.pageV.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.1);
    self.pageV.center=CGPointMake(self.frame.size.width/2, self.frame.size.height-self.pageV.frame.size.height/2);
    self.pageV.numberOfPages=self.imageArr.count;
    self.pageV.currentPage=0;
    self.pageV.pageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageV.currentPageIndicatorTintColor=[UIColor whiteColor];
    
    //
    self.btn.frame=CGRectMake(0, 0, self.frame.size.width*0.5, self.frame.size.height*0.05);
    self.btn.center=CGPointMake(self.frame.size.width/2, self.pageV.frame.origin.y-self.btn.frame.size.height/2);
    self.btn.hidden=YES;
    self.btn.backgroundColor=[UIColor clearColor];
    self.btn.layer.masksToBounds=YES;
    self.btn.layer.cornerRadius=self.btn.frame.size.height/2;
    self.btn.layer.borderWidth=1.0;
    self.btn.layer.borderColor=[UIColor whiteColor].CGColor;
    [self.btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.btn addTarget:self action:@selector(removeViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setTitle:@"开始体验" forState:UIControlStateNormal];
}

-(void)removeViewBtn:(UIButton *)sender
{
    sender.backgroundColor=[UIColor clearColor];
    [self removeFromSuperview];//删除试图
}
-(void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor=kHighlighted;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINib*nib=[UINib nibWithNibName:@"PageCollectionViewCell" bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    PageCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imagev.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    cell.imagev.image=[UIImage imageNamed:self.imageArr[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((scrollView.contentOffset.x/self.frame.size.width)==self.imageArr.count-1) {
        [self performSelector:@selector(btnHidden:) withObject:self.btn afterDelay:kAfterDelayTime];
    }else{
        self.btn.hidden=YES;
    }
}

-(void)btnHidden:(UIButton *)btn
{
    btn.hidden=NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page=scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageV.currentPage=page;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
