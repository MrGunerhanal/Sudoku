//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import "HeaderPuzzle.h"
#import "HeaderSolution.h"
#import "HeaderPosition.h"


@implementation Puzzle {
    
}

- (instancetype)initSolution:(Solution *)solution difficulty: (puzzleDifficulty) difficulty {
    self = [super init];
    
    _solution = solution;
    _grid = [solution copy];
    _difficulty = diff;
    
    [self generate];
    
    return self;
}

- (void) erasePosition: (Position *) pos {
    
    pos.value = @(0);
    
}

- (void) generate {
    
    int numbersToRemove = _difficulty + arc4random_uniform(3);
    
    NSMutableArray *available = [NSMutableArray new];
    
    for (int i = 0; i < 81; i++) {
        [available addObject:@(i)];
    }
    
    while (numbersToRemove > 0) {
        NSUInteger index = arc4random_uniform((uint32_t)available.count);
        NSNumber * gridpos = available[index];
        [available removeObjectAtIndex:index];
        
        Position* pos = [_grid positionAtIndex:gridpos.unsignedIntegerValue];
        [self erasePosition:pos];
        
        numbersToRemove--;
    }
}


-(BOOL) correctAnswerAtPosition:(int)pos {
    
    Position* gridPos = [_grid positionAtIndex:pos];
    Position* solutionPos = [_solution positionAtIndex:pos];
    
    return [gridPos.value isEqualToValue:solutionPos.value];
    
}


@end
