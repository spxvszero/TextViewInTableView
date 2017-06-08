//
//  TextTableViewController.m
//  TextViewCell
//
//  Created by jacky on 16/2/18.
//  Copyright © 2016年 com.jacky.cc. All rights reserved.
//

#import "TextTableViewController.h"


#define identify @"cell"

#define sectionNum 2

@interface TextTableViewController ()<TextViewCellDelegate>

@property(nonatomic,strong) NSMutableArray *indexPaths;
@property(nonatomic,strong) NSMutableDictionary *textHeights;


@property(nonatomic,strong) NSMutableArray *textCellHeights;

@property(nonatomic,assign) CGFloat textHeight;

@end

@implementation TextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.cellDelegate = self;
    
    return cell;
}

- (void)textViewCell:(TextViewCell *)cell changeHeight:(CGFloat)height
{
    //存储indexPath和height
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    self.textCellHeights[indexP.section][@(indexP.row)] = @(height);
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic = self.textCellHeights[indexPath.section];
    for (NSNumber *num in dic) {
            if ([num isEqualToNumber:@(indexPath.row)]) {
                return MAX(50, [dic[@(indexPath.row)] doubleValue]+10);
            }
    }
    return 50;
}


#pragma mark - 懒加载

- (NSMutableArray *)indexPaths
{
    if (_indexPaths == nil) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (NSMutableDictionary *)textHeights
{
    if (_textHeights == nil) {
        _textHeights = [NSMutableDictionary dictionary];
    }
    return _textHeights;
}

- (NSMutableArray *)textCellHeights
{
    if (_textCellHeights == nil) {
        _textCellHeights = [NSMutableArray array];
        for (int i = 0; i < sectionNum; i++) {
            [_textCellHeights addObject:[NSMutableDictionary dictionary]];
        }
    }
    return _textCellHeights;
}

@end



@interface TextViewCell ()<UITextViewDelegate>

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,assign) CGFloat textHeight;

@end


@implementation TextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textView = [[UITextView alloc] init];
        self.textView.layer.borderWidth = 2;
        self.textView.layer.borderColor = [UIColor blackColor].CGColor;
        self.textView.delegate = self;
        self.textView.alwaysBounceHorizontal = NO;
        self.textView.alwaysBounceVertical = NO;
        NSLog(@"heightAnchor---- %@",self.textView.heightAnchor);
        [self addSubview:self.textView];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textHeight == self.textView.contentSize.height) {
        return;
    }
    self.textHeight = self.textView.contentSize.height;
    
    //这里需要通知cell改变高度
    if ([self.cellDelegate respondsToSelector:@selector(textViewCell:changeHeight:)]) {
        [self.cellDelegate textViewCell:self changeHeight:self.textView.contentSize.height];
    }
    
    [self adjustTextOffset];
}

- (void)adjustTextOffset
{
    [self.textView setContentOffset:CGPointZero animated:NO];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//   //约束
//    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *up = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:5];
//    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-5];
//    NSLayoutConstraint *down = [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-5];
//    
//    [self addConstraints:@[up,left,right,down]];
    
    //直接设置frame，二选一都可以
    self.textView.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10);
}

@end
