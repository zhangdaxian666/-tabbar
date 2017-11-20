//
//  XRWaterfallLayout.m
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "XRWaterfallLayout.h"
@interface  XRWaterfallLayout()

@property(nonatomic,strong)NSMutableDictionary*maxYDic;

@property(nonatomic,strong)NSMutableArray*attributesArray;
@end

@implementation XRWaterfallLayout

#pragma mark-懒加载
-(NSMutableDictionary *)maxYDic
{
    if (!_maxYDic) {
        _maxYDic=[[NSMutableDictionary alloc]init];
    }
    return _maxYDic;
}

-(NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray=[NSMutableArray array];
    }
    return _attributesArray;
}

#pragma mark-构造方法
-(instancetype)init{
    if (self=[super init]) {
        self.columnCount=2;
    }
    return self;
}
-(instancetype)initWithColumnCount:(NSInteger)columnCount{
    if (self=[super init]) {
        self.columnCount=columnCount;
    }
    return self;
}

+(instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount{
    return [[self alloc]initWithColumnCount:columnCount];
}

#pragma mark-相关设置方法      间距
-(void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset{
    self.columnSpacing=columnSpacing;
    self.rowSpacing=rowSepacing;
    self.sectionInset=sectionInset;
}

#pragma mark-布局相关方法
-(void)prepareLayout{
    [super prepareLayout];
    
    for (int i=0; i<self.columnCount; i++) {
        self.maxYDic[@(i)]=@(self.sectionInset.top);
    }

    NSInteger itemCount=[self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
   
    for (int i=0; i<itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

-(CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex=@0;
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key,NSNumber *obj,BOOL *stop) {
        if ([self.maxYDic[maxIndex] floatValue]<obj.floatValue) {
            maxIndex=key;
        }
    }];
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue]+self.sectionInset.bottom);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    //item的宽度=（collectionview的宽度-内边距与列间距）／列数
    CGFloat itemWidth=(collectionViewWidth-self.sectionInset.left-self.sectionInset.right-(self.columnCount-1)*self.columnSpacing)/self.columnCount;
    
    CGFloat itemHeight = 0;

    if (self.itemHeightBlock) itemHeight = self.itemHeightBlock(itemWidth,indexPath);
    else{
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)])
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
//找到最短的那一列
    __block NSNumber *minIndex=@0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key,NSNumber *obj, BOOL *stop){
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
//根据最短列的列数计算iteem的x值
    CGFloat itemX = self.sectionInset.left+(self.columnSpacing+itemWidth)*minIndex.integerValue;
    //item的y值 = 最短的最大y值 + 行间距
    CGFloat itemY=[self.maxYDic[minIndex] floatValue]+self.rowSpacing;
    //
    attributes.frame=CGRectMake(itemX, itemY, itemWidth, itemHeight);
    //更新字典里的最大y值
    self.maxYDic[minIndex]=@(CGRectGetMaxY(attributes.frame));
    
    return attributes;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}
@end
