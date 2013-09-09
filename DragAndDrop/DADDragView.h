//
//  DADDragView.h
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/8/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DADDragView : UIView

@property (nonatomic, copy) void (^touchBegan)(UITouch *touch);

@property (nonatomic, copy) void (^touchMoved)(UITouch *touch);

@property (nonatomic, copy) void (^touchEnded)(UITouch *touch);

@end
