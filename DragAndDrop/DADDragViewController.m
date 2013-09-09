//
//  DADDragViewController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/8/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADDragViewController.h"
#import "DADDragView.h"

@interface DADDragViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (assign, nonatomic) IBOutlet DADDragView *dragView;
@property (assign, nonatomic) IBOutlet DADDragView *dragView2;
@property (assign, nonatomic) CGPoint offset;
@property (assign, nonatomic) CGPoint startPos;

@end

@implementation DADDragViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dragView.touchBegan = ^(UITouch *touch){
        DADDragView *view = (DADDragView*)[touch view];
        _offset = [touch locationInView:[touch view]];
        _startPos = _dragView.frame.origin;
        
        // Bring the button to the front.
        [self.view bringSubviewToFront:view];
        [self.view bringSubviewToFront:_backButton];
    };
    
    _dragView.touchMoved = ^(UITouch *touch){
        DADDragView *view = (DADDragView*)[touch view];
        CGPoint pointInController = [touch locationInView:self.view];
        
        CGRect frame = view.frame;
        frame.origin.x = pointInController.x - _offset.x;
        frame.origin.y = pointInController.y - _offset.y;
        view.frame = frame;
    };
    
    _dragView.touchEnded = ^(UITouch *touch){
        
    };
    
    _dragView2.touchBegan = _dragView.touchBegan;
    _dragView2.touchMoved = _dragView.touchMoved;
    _dragView2.touchEnded = _dragView2.touchEnded;
}
- (IBAction)backTouch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
