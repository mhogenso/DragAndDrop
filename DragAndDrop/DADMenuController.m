//
//  DADMenuController.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/9/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADMenuController.h"

@interface DADMenuController ()
@property (strong, nonatomic) IBOutlet UITableView *menuView;
@property (strong, nonatomic) NSArray *nameList;

@end

@implementation DADMenuController

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
    
    _nameList = @[ @"Drag and Clone", @"Drag and Drop", @"Drag Across" ];
    
    _menuView.delegate = self;
    _menuView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _nameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _nameList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"segue1" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"segue2" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"segue3" sender:self];
            break;
        default:
            break;
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
