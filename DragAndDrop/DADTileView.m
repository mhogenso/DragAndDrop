//
//  DADTile.m
//  DragAndDrop
//
//  Created by Michael Hogenson on 9/4/13.
//  Copyright (c) 2013 Michael Hogenson. All rights reserved.
//

#import "DADTileView.h"

@implementation DADTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchBegan) {
        _touchBegan([touches anyObject]);
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchMoved) {
        _touchMoved([touches anyObject]);
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchEnded) {
        _touchEnded([touches anyObject]);
    }
}

@end
