//
//  DADDragAcrossViewViewController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/10/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADCanvasViewController.h"
#import "DADDragView.h"

#define DAD_ANIMATION_DURATION 0.15
#define DAD_STEAL_THRESHOLD 10

@interface DADCanvasViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DADCanvasViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [@(indexPath.row) stringValue];
    
    DADDragView *strongDragView = [[DADDragView alloc] initWithFrame:cell.contentView.frame];
    
    __weak __block DADDragView *dragView = strongDragView;
    
    
    dragView.backgroundColor = [UIColor colorWithRed:(arc4random()*1.0f/UINT_MAX) green:(arc4random()*1.0f/UINT_MAX) blue:(arc4random()*1.0f/UINT_MAX) alpha:1.0f];
    
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
            
            if (dx >= DAD_STEAL_THRESHOLD) {
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






