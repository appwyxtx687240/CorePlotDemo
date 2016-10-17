//
//  ZJSubScoreCell.m
//  CorePlotDemo
//
//  Created by Summer on 2016/10/17.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ZJSubScoreCell.h"

@interface ZJSubScoreCell()

/**
 风险标题
 */
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

/**
 简短说明
 */
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;

/**
 评分
 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ZJSubScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];


}

-(void)setScore:(ZJSubjectScoreModel *)score {
    _score = score;

    self.subTitleLabel.text = score.score_card_titile;

    self.briefLabel.text = score.score_card_brief;

    NSString *scoreValue = [NSString stringWithFormat:@"%@分", score.score_card_value];
    NSMutableAttributedString *attrScore = [[NSMutableAttributedString alloc]initWithString:scoreValue];
    [attrScore addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, attrScore.length - 1)];
    self.scoreLabel.attributedText = attrScore;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
