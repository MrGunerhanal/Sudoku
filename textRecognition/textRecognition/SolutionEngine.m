//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import "HeaderSolution.h"
#import "HeaderPosition.h"

@interface Solution ()

@property NSMutableArray * positions;
@property NSMutableArray * grid;
@property NSMutableArray * numbers;
@property NSUInteger popIndex;
@property NSUInteger valueIndex;

@end

@implementation Solution {
}

- (instancetype) init {
    [self generateStructs];
    return self;
}

- (instancetype)initSolutionWithArray:(NSArray *)arrayOfValues {
    self = [self init];
    
    NSUInteger i = 0;
    for (NSNumber* num in arrayOfValues) {
        Position* pos = [self positionAtIndex:i];
        pos.value = num;
        i++;
    }
    
    self = [self initSolution];
    
    return self;
}

- (instancetype) initSolution {
    NSMutableArray *rowValues = [NSMutableArray array];
    
    for (NSUInteger row = 0; row < 9; row++) {
        NSMutableSet *set = [NSMutableSet setWithArray:_numbers];
        
        NSArray* arrayOfPos = [self getRow:row];
        for (Position * pos in arrayOfPos) {
            if (pos.value.integerValue != 0)
                [set removeObject:pos.value];
        }
        
        [rowValues addObject:set];
    }
    
    NSMutableArray *colValues = [NSMutableArray array];
    
    for (NSUInteger col = 0; col < 9; col++) {
        NSMutableSet *set = [NSMutableSet setWithArray:_numbers];
        
        NSArray* arrayOfPos = [self getCol:col];
        for (Position * pos in arrayOfPos) {
            if (pos.value.integerValue != 0)
                [set removeObject:pos.value];
        }
        
        [colValues addObject:set];
    }
    
    NSMutableArray *gridValues = [NSMutableArray array];
    
    for (NSUInteger grid = 0; grid < 9; grid++) {
        NSMutableSet *set = [NSMutableSet setWithArray:_numbers];
        
        NSArray* arrayOfPos = [self getGrid:(grid / 3) * 3 col: (grid % 3) * 3];
        for (Position * pos in arrayOfPos) {
            if (pos.value.integerValue != 0)
                [set removeObject:pos.value];
        }
        
        [gridValues addObject:set];
    }
    
    [_positions removeAllObjects];
    
    for (NSUInteger i = 0; i < 81; i++) {
        Position * pos = [self positionAtIndex:i];
        
        [pos.likelyValues removeAllObjects];
        
        if (pos.value.integerValue == 0) {
            [_positions addObject: pos];
            
            NSMutableSet * set = [NSMutableSet setWithArray:_numbers];
            NSSet* rowSet = rowValues[pos.y];
            NSSet* colSet = colValues[pos.x];
            NSSet* gridSet = gridValues[(pos.y / 3) * 3 + (pos.x / 3)];
            
            [set intersectSet:rowSet];
            [set intersectSet:colSet];
            [set intersectSet:gridSet];
            
            [pos.likelyValues addObjectsFromArray:set.allObjects];
            
        }
    }
    
    [_positions sortUsingComparator:[Position comparator]];
    
    self.popIndex = 0;
    self.valueIndex = 0;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Solution * newSelf = [Solution new];
    newSelf.grid = [[NSMutableArray alloc]initWithArray:_grid copyItems:YES];
    newSelf.numbers = [[NSMutableArray alloc]initWithArray:_numbers copyItems:YES];
    newSelf.positions = [NSMutableArray new];
    
    for (Position * p in _positions) {
        [newSelf.positions addObject:[newSelf getAtX:p.x Y:p.y]];
    }
    
    newSelf.popIndex = _popIndex;
    newSelf.valueIndex = _valueIndex;
    
    return newSelf;
}

- (void) generateStructs {
    NSUInteger i = 0;
    
    _popIndex = 0;
    _valueIndex = 0;
    _grid = [NSMutableArray new];
    _positions = [NSMutableArray new];
    _numbers = [NSMutableArray new];
    
    while (i++ < 9) {
        [_numbers addObject:@(i)];
    }
    
    i = 0;
    
    while (i < 81) {
        Position * pos = [[Position alloc] initializeWithX: i % 9 Y: i / 9];
        [_positions addObject:pos];
        [_grid addObject:pos];
        i++;
    }
}

- (BOOL) nextSolution {
    _valueIndex++;
    Position* pos = [self getMostConstrained];
    return pos != nil && pos.likelyValues.count > _valueIndex;
}

- (SolutionCase) converge {
    
    Position * pos = nil;
    pos = [self getMostConstrained];
    
    if (pos != nil) {
        
        assert([_grid indexOfObject:pos] != NSNotFound);
        
        //get a random value from it's set
        pos.value = [self generateRandomValueFromPosition:pos];
        
        if (pos.value.integerValue != 0) {
            
            [self decrease:pos];
            assert(pos.value.integerValue != 0);
            
            if ([self isValid]) {
                _valueIndex = 0;
                _popIndex = 0;
                return _positions.count == 0 ? Solved : Progress;
            }
        }
    }
    
    return Invalid;
}

- (BOOL) isValid {
    return _positions.count == 0 || [self getMostConstrained].likelyValues.count > 0;
}

- (void) checkAscending {
    int off = (int) _positions.count - 1;
    off--;
    while (off > 0) {
        Position * pos0 = _positions[(NSUInteger) off];
        Position * pos1 = _positions[(NSUInteger) off+1];
        
        assert(pos0.likelyValues.count <= pos1.likelyValues.count);
        off--;
    }
}

- (void) printPossibleValues {
    NSUInteger off = 0;
    
    NSLog(@"Undetermined count %d", (int)_positions.count);
    while (off < _positions.count) {
        Position * pos0 = _positions[off];
        
        NSLog(@"Pos (%lu, %lu):  value: %@, %@", pos0.x, pos0.y, pos0.value, [pos0.likelyValues componentsJoinedByString:@","]);
        
        off ++;
        
    }
}

- (void) printGrid {
    NSUInteger off = 0;
    while (off < 81) {
        Position * pos0 = _grid[off+0];
        Position * pos1 = _grid[off+1];
        Position * pos2 = _grid[off+2];
        Position * pos3 = _grid[off+3];
        Position * pos4 = _grid[off+4];
        Position * pos5 = _grid[off+5];
        Position * pos6 = _grid[off+6];
        Position * pos7 = _grid[off+7];
        Position * pos8 = _grid[off+8];
        
        NSLog(@"%@ %@ %@ | %@ %@ %@ | %@ %@ %@",
              pos0.writableValue,
              pos1.writableValue,
              pos2.writableValue,
              pos3.writableValue,
              pos4.writableValue,
              pos5.writableValue,
              pos6.writableValue,
              pos7.writableValue,
              pos8.writableValue);
        
        off += 9;
        if (off == 27 || off == 54)
            NSLog(@"---------------------");
    }
    NSLog(@"\n");
}

- (Position *) getMostConstrained {
    Position * retval = nil;
    if (_popIndex < _positions.count) {
        retval = _positions[_popIndex];
    }
    return retval;
}

- (Position *) positionAtIndex: (NSUInteger) index {
    return _grid[index];
}

- (void) removePosition: (Position *) pos {
    [_positions removeObject:pos];
    
    NSUInteger col = pos.x;
    NSUInteger row = pos.y;
    NSUInteger i = 0;
    
    NSArray *rowArr = [self getRow:row];
    NSArray *colArr = [self getCol:col];
    NSArray *gridArr = [self getGrid:row col:col];
    
    while (i < 9) {
        [(Position *) rowArr[i] remove:pos.value];
        [(Position *) colArr[i] remove:pos.value];
        [(Position *) gridArr[i] remove:pos.value];
        i++;
    }
    
    [_positions sortUsingComparator:[Position comparator]];
}

- (BOOL) isValue: (NSNumber*) value inSet: (NSArray*) arrayOfPositions {
    for (NSUInteger i = 0; i < arrayOfPositions.count; i++) {
        Position * posToTest = arrayOfPositions[i];
        if ([posToTest.value isEqualToNumber:value])
            return true;
    }
    
    return false;
}

- (void) decrease: (Position *) pos {
    
    bool bCanReduceFurther;
    
    do {
        if (pos != nil)
            [self removePosition:pos];
        
        [self checkAscending];
        
        bCanReduceFurther = _positions.count > 0 && ((Position *)_positions[0]).likelyValues.count == 1;
        
        if (bCanReduceFurther) {
            pos = _positions[0];
            pos.value = pos.likelyValues.lastObject;
        }
        
    } while (bCanReduceFurther);
}

- (NSNumber *) generateRandomValueFromPosition: (Position *) pos {
    
    NSMutableArray* set = pos.likelyValues;
    NSNumber *value;
    
    if (_valueIndex < set.count) {
        value = set[_valueIndex];
    }
    
    return value;
}

- (Position *) getAtX: (NSUInteger) col Y: (NSUInteger) row {
    return _grid[row * 9 + col];
}

- (NSArray*) getRow: (NSUInteger) row {
    NSMutableArray * array = [NSMutableArray new];
    
    NSUInteger i = 0;
    while (i < 9){
        Position * pos = _grid[row * 9 + i];
        [array addObject: pos];
        assert(pos.y == row);
        i++;
    }
    
    return array;
}

- (NSArray*) getCol: (NSUInteger) col {
    NSMutableArray * array = [NSMutableArray new];
    
    NSUInteger i = 0;
    while (i < 9){
        Position * pos = _grid[i * 9 + col];
        [array addObject: pos];
        assert(pos.x == col);
        i++;
    }
    
    return array;
}

- (NSArray*) getGrid: (NSUInteger) row col: (NSUInteger) col {
    NSMutableArray * array = [NSMutableArray new];
    
    NSUInteger i = 0, j = 0;
    NSUInteger gridOffset = ((row / 3) * 3) * 9 + ((col / 3) * 3);
    
    while (i < 3){
        j = 0;
        while (j < 3) {
            Position * pos = _grid[gridOffset + (i * 9) + j];
            
            [array addObject:pos];
            j++;
        }
        i++;
    }
    
    return array;
}

- (BOOL)isEqual:(id)object {
    
    if ([object isKindOfClass:Solution.class]) {
        Solution* solution = object;
        for (NSUInteger i = 0; i < 81; i++) {
            if (((Position*)_grid[i]).value != [solution positionAtIndex:i].value)
                return false;
        }
        return true;
    }
    return false;
}

@end
