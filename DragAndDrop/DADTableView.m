//
//  DADTableView.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/11/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADTableView.h"

@interface DADTableView ()

@end

@implementation DADTableView

/*#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}*/

- (NSInteger)numberOfSections{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:@"cell"];
}

@end
