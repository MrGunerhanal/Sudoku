//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Solution;

typedef enum {
    diff = 40,
} puzzleDifficulty;

@interface Puzzle : NSObject

- (instancetype) initSolution: (Solution *) solution difficulty: (puzzleDifficulty) difficulty;

@property Solution * solution;

@property Solution * grid;

@property (readonly) puzzleDifficulty difficulty;

-(BOOL) correctAnswerAtPosition:(int)pos;

@end
