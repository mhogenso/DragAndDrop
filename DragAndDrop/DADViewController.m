//
//  DADViewController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/4/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADViewController.h"
#import "DADTileView.h"

@interface DADViewController ()

// atomic is thread safe
@property (weak, nonatomic) IBOutlet DADTileView *tile;
@property (assign, nonatomic) CGPoint offset;
@property (strong, nonatomic) DADTileView *newtile;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation DADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tile.touchBegan = ^(UITouch *touch){
        _offset = [touch locationInView:[touch view]];
        _newtile = [[DADTileView alloc] init];
        _newtile.touchBegan = _tile.touchBegan;
        _newtile.touchMoved = _tile.touchMoved;
        _newtile.touchEnded = _tile.touchEnded;
        [self.view addSubview:_newtile];
        // NSLog(@"%f %f", point.x, point.y);
        // CGPoint point = [touch locationInView:self.view];
        // _newtile = [[DADTile alloc] init];
        // NSLog(@"%f %f", point.x, point.y);
        
        // Bring the button to the front.
        [self.view bringSubviewToFront:_resetButton];
    };
    
    _tile.touchMoved = ^(UITouch *touch){
        CGPoint pointInController = [touch locationInView:self.view];
        
        CGRect frame = _tile.frame;
        frame.origin.x = pointInController.x - _offset.x;
        frame.origin.y = pointInController.y - _offset.y;
        _newtile.frame = frame;
        // _newtile.backgroundColor = [UIColor redColor];
        _newtile.backgroundColor = [touch view].backgroundColor;
        	
    };
    
    _tile.touchEnded = ^(UITouch *touch){
        _newtile = nil;
    };
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetTouch:(id)sender {
    for (UIView *subview in self.view.subviews) {
        if (![subview isEqual:sender] && ![subview isEqual:(_tile)]) {
            [subview removeFromSuperview];
        }
    }
}

@end
