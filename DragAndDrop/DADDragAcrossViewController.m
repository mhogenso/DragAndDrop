//
//  DADDragAcrossViewViewController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/10/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADDragAcrossViewController.h"
#import "DADDragView.h"
#import "DADMenuController.h"

#define DAD_ANIMATION_DURATION 0.15

@interface DADDragAcrossViewController ()

@property (weak, nonatomic) IBOutlet UIView *sidebar;
@property (assign, nonatomic) IBOutlet DADDragView *redTile;
@property (weak, nonatomic) IBOutlet DADDragView *blueTile;
@property (weak, nonatomic) IBOutlet DADDragView *greenTile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    
    // UIPopoverController *popOverController = [[UIPopoverController alloc] initWithContentViewController:tableResultViewController];
    
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

#pragma mark UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [@(indexPath.row) stringValue];
    
    DADDragView *strongDragView = [[DADDragView alloc] initWithFrame:cell.contentView.frame];
    
    __weak __block DADDragView *dragView = strongDragView;
    
    
    dragView.backgroundColor = [UIColor colorWithRed:(arc4random()*1.0f/UINT_MAX) green:(arc4random()*1.0f/UINT_MAX) blue:(arc4random()*1.0f/UINT_MAX) alpha:(arc4random()*1.0f/UINT_MAX)];
    
    dragView.touchBegan = ^(UITouch *touch){
        // Pull out the view that was touched.
        UIView *view = touch.view;
        
        // Figure out position of new view.
        CGPoint offset = [touch locationInView:view];
        
        // Calculate the new frame of the tile.
        CGPoint pointInController = [touch locationInView:self.view];
        
        CGRect frame = view.frame;
        frame.origin.x = pointInController.x - offset.x;
        frame.origin.y = pointInController.y - offset.y;
        
        // Copy view and add it to the view controller.
        DADDragView *dragTile = [[DADDragView alloc] init];
        dragTile.frame = frame;
        [dragTile setBackgroundColor:[view backgroundColor]];
        
        
        dragView.touchMoved = ^(UITouch *touch){
            CGPoint pointInController = [touch locationInView:self.view];
            
            CGPoint movedPoint = [touch locationInView:touch.view];
            
            CGFloat dx = movedPoint.x - offset.x;
            
            if (dx >= 0.5) {
                if (tableView.scrollEnabled) {
                    [UIView animateWithDuration:DAD_ANIMATION_DURATION
                                     animations:^{
                                         CGRect frame = tableView.frame;
                                         frame.origin.x -= frame.size.width;
                                         tableView.frame = frame;
                                     }];
                }
                tableView.scrollEnabled = NO;
                [self.view addSubview:dragTile];
                [self.view bringSubviewToFront:tableView];
            }
            
//            NSLog(@"dx: %f dy: %f", movedPoint.x - offset.x, movedPoint.y - offset.y);
            
            CGRect frame = dragTile.frame;
            frame.origin.x = pointInController.x - offset.x;
            frame.origin.y = pointInController.y - offset.y;
            dragTile.frame = frame;
        };
        
        dragView.touchEnded = ^(UITouch *touch) {
            if (!tableView.scrollEnabled) {
                [UIView animateWithDuration:DAD_ANIMATION_DURATION
                                 animations:^{
                                     CGRect frame = tableView.frame;
                                     frame.origin.x += frame.size.width;
                                     tableView.frame = frame;
                                 }];
            }
            tableView.scrollEnabled = YES;
        };
    };
    
    
    
    [cell.contentView addSubview:dragView];
    
    return cell;
}

@end






