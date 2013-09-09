//
//  DADDragViewController.h
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/8/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DADDragViewControllerDelegate;

@interface DADDragViewController : UIViewController

@property (assign, nonatomic) CGPoint point1;
@property (assign, nonatomic) CGPoint point2;

@property (weak, nonatomic) id<DADDragViewControllerDelegate> delegate;

@property (copy, nonatomic)  void (^didFinishBlock)();

@end

@protocol DADDragViewControllerDelegate <NSObject>

- (void)dragViewControllerDidFinish:(DADDragViewController *)viewController;

@end