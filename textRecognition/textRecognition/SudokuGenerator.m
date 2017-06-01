//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import "SudokuGenerator.h"
#import "HeaderSolution.h"
#import "HeaderPuzzle.h"

@implementation SudokuGenerator {
    NSMutableArray * stackSolution;
};

- (instancetype) init {
    stackSolution = [NSMutableArray new];
    return self;
};

- (Solution *) giveSolution: (Solution*) initState {
    Solution *solution = nil;
    
    int i = 0;
    while (i < 1) {
        
        int trackCount = 0;
        solution = initState ? initState.copy : [Solution new];
        
        [solution decrease:nil];
        
        SolutionCase Case, prevCase;
        [stackSolution addObject:[solution copy]];
        
        do {
            prevCase = Case;
            Case = [solution converge];
            switch (Case) {
                case Solved:
                    NSLog(@"Puzzle solved!!! Track count %d", trackCount);
                    //[solution printGrid];
                    [stackSolution removeAllObjects];
                    break;
                case Progress:
                    [stackSolution addObject:[solution copy]];
                    break;
                case Invalid:
                    solution = [stackSolution lastObject];
                    if(![solution nextSolution]) {
                        [stackSolution removeLastObject];
                        trackCount++;
                    } else {
                        solution = [solution copy];
                    }
                    break;
            }
            
        } while (Case != Solved && solution);
        
        i++;
        
        if (solution == nil)
            NSLog(@"Track count %d", trackCount);
    }
    
    return solution;
}

- (Puzzle *)generatePuzzleWithSolution:(Solution *)solution difficulty: (puzzleDifficulty) difficulty {
    return [[Puzzle alloc] initSolution:solution difficulty: difficulty];
}

- (Puzzle *)generate: (puzzleDifficulty) difficulty {
    Solution * solution = [self giveSolution: nil];
    Puzzle * puzzle = [self generatePuzzleWithSolution:solution difficulty: difficulty];
    
    return puzzle;
}

@end
