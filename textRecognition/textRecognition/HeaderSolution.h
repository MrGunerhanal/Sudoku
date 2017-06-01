//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Position;

typedef enum  {
    Invalid,
    Progress,
    Solved
} SolutionCase;

@interface Solution : NSObject<NSCopying>

- (instancetype) initSolution;
- (instancetype) initSolutionWithArray: (NSArray*) arrayOfValues;

- (BOOL) isValid;

- (SolutionCase) converge;

- (void) decrease: (Position*) pos;

- (void) printGrid;

- (BOOL) nextSolution;

- (Position*) positionAtIndex: (NSUInteger) index;

- (void) removePosition: (Position *) pos;

- (Position *) getAtX: (NSUInteger) col Y: (NSUInteger) row;

@end
