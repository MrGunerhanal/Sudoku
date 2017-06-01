//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderPuzzle.h"

@class Solution;
@class Puzzle;

@interface SudokuGenerator : NSObject

- (Solution*) giveSolution: (Solution*) initialState;

- (Puzzle *) generatePuzzleWithSolution:(Solution *)solution difficulty: (puzzleDifficulty) difficulty;

- (Puzzle *) generate: (puzzleDifficulty) difficulty;

@end
