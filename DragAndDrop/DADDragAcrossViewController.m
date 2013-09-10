//
//  DADDragAcrossViewViewController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/10/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADDragAcrossViewController.h"
#import "DADDragView.h"

@interface DADDragAcrossViewController ()

@property (weak, nonatomic) IBOutlet UIView *sidebar;
@property (assign, nonatomic) IBOutlet DADDragView *redTile;
@property (weak, nonatomic) IBOutlet DADDragView *blueTile;
@property (weak, nonatomic) IBOutlet DADDragView *greenTile;
@property (assign, nonatomic) CGPoint offset;
@property (assign, nonatomic) CGPoint startPos;
@property (strong, nonatomic) DADDragView *dragTile;

@end

@implementation DADDragAcrossViewController

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
	
    _redTile.touchBegan = ^(UITouch *touch){
        // _offset = [touch locationInView:(UIViewController *)self];
        // _startPos = _redTile.frame.origin;
        
        // Create a new tile that is a copy of the one touched.
        // DADDragView *copy = [[DADDragView alloc] init];
        // [self.view addSubview:copy];
        
        // Pull out the view that was touched.
        UIView *view = touch.view;
        
        // Figure out position of new view.
        _offset = [touch locationInView:view];
        CGPoint localPoint = [view bounds].origin;
        _startPos = [view convertPoint:localPoint toView:nil];
        
        // Calculate the new frame of the tile.
        CGPoint pointInController = [touch locationInView:self.view];
        
        CGRect frame = view.frame;
        frame.origin.x = pointInController.x - _offset.x;
        frame.origin.y = pointInController.y - _offset.y;
        
        // Copy view and add it to the view controller.
        _dragTile = [[DADDragView alloc] init];
        _dragTile.frame = frame;
        [_dragTile setBackgroundColor:[view backgroundColor]];
        [self.view addSubview:_dragTile];
        
        _sidebar.hidden=YES;
    };
    
    _redTile.touchMoved = ^(UITouch *touch){
        // DADDragView *view = (DADDragView*)[touch view];
        CGPoint pointInController = [touch locationInView:self.view];
        
        CGRect frame = _dragTile.frame;
        frame.origin.x = pointInController.x - _offset.x;
        frame.origin.y = pointInController.y - _offset.y;
        _dragTile.frame = frame;
    };
    
    _redTile.touchEnded = ^(UITouch *touch){
        _sidebar.hidden = NO;
        [self.view bringSubviewToFront:_sidebar];
    };
    
    _blueTile.touchBegan = _redTile.touchBegan;
    _blueTile.touchMoved = _redTile.touchMoved;
    _blueTile.touchEnded = _redTile.touchEnded;
    
    _greenTile.touchBegan = _redTile.touchBegan;
    _greenTile.touchMoved = _redTile.touchMoved;
    _greenTile.touchEnded = _redTile.touchEnded;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
