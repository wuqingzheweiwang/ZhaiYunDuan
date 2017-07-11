//
//  UITextField+BXExtension.m
//  债云端
//
//  Created by 赵凯强 on 2017/7/11.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//


#import "UITextField+BXExtension.h"

@implementation UITextField (BXExtension)

- (NSRange)selectedRange {
    // 文首的位置
    UITextPosition *beginning = self.beginningOfDocument;
    
    // 内容为[start,end)，无论是否有选取区域，start都描述了光标的位置
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    // 获取以from为基准的to的偏移
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range  // 备注：UITextField必须为第一响应者才有效
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    
    // 创建一个UITextRange
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}
@end
