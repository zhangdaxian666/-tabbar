//
//  CustomCell.m
//  启示页
//
//  Created by slcf888 on 2017/8/31.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "CustomCell.h"
#import "UIImageView+WebCache.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KRate KWidth/320.0

#import "Masonry.h"
#define kWS(ws) __weak typeof(&*self) ws=self   //防止重调

@implementation CustomCell
{
    UIImageView *_headImageView;
    UILabel *_nameLabel;
    UILabel *_desLabel;
    UILabel *_timeLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}
-(void)configCell{
    kWS(ws);
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor blueColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(ws.contentView).offset(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    _desLabel = [UILabel new];
    _desLabel.textColor = [UIColor blackColor];
    _desLabel.font = [UIFont systemFontOfSize:15];
    _desLabel.numberOfLines = 1;
    //_desLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _desLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
        //make.size.mas_equalTo(CGSizeMake(210, 20));
    }];

    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_desLabel.mas_bottom).offset(10);
        
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
        //make.size.mas_equalTo(CGSizeMake(210, 20));
    }];

}

-(void)fileData:(JsonGetModel *)model
{
    NSURL *url=[NSURL URLWithString:model.iconUrl];
    [_headImageView sd_setImageWithURL:url];
    
    _nameLabel.text=model.name;
    _desLabel.text=model.description1;
    _timeLabel.text=model.updataDate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
