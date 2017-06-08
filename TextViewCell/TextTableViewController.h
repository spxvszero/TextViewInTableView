//
//  TextTableViewController.h
//  TextViewCell
//
//  Created by jacky on 16/2/18.
//  Copyright © 2016年 com.jacky.cc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TextViewCell;

@protocol TextViewCellDelegate <NSObject>

- (void)textViewCell:(TextViewCell *)cell changeHeight:(CGFloat)height;

@end

@interface TextViewCell : UITableViewCell

@property(nonatomic,weak) id<TextViewCellDelegate> cellDelegate;

- (void)adjustTextOffset;

@end


@interface TextTableViewController : UITableViewController



@end
