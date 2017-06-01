//
//  Created by Burak Gunerhanal on 04/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

#import "HeaderPosition.h"

static NSComparator comparator = ^NSComparisonResult(Position *pos1, Position *pos2) {
    if (pos1.likelyValues.count < pos2.likelyValues.count)
        return NSOrderedAscending;
    else if (pos1.likelyValues.count == pos2.likelyValues.count) {
        return NSOrderedSame;
    } else
        return NSOrderedDescending;
};

@implementation Position

+ (NSComparator)comparator {
    return comparator;
}

- (instancetype) initializeWithX: (NSUInteger) x Y: (NSUInteger) y {
    
    self.value = @(0);
    self.x = x;
    self.y = y;
    self.likelyValues = [self shuffleTeam:[[NSMutableArray alloc] initWithArray:
                                            @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9)]]
                           ];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Position * newPos = [Position new];
    
    newPos.value = self.value;
    newPos.x = self.x;
    newPos.y = self.y;
    newPos.likelyValues = [[[NSMutableArray alloc] initWithArray:self.likelyValues] mutableCopy];
    
    return newPos;
}

- (NSMutableArray*) shuffleTeam: (NSMutableArray*) array {
    
    NSUInteger i = array.count;
    while (i > 1) {
        uint32_t randomInd1 = arc4random_uniform((uint32_t)array.count);
        uint32_t randomInd2 = arc4random_uniform((uint32_t)array.count);
        
        if (randomInd1 != randomInd2) {
            id val = array[randomInd1];
            array[randomInd1] = array[randomInd2];
            array[randomInd2] = val;
            i--;
        }
    }
    
    return array;
}

- (void) remove: (id) value {
    [self.likelyValues removeObject:value];
}

- (void) add: (id) value {
    if (![self.likelyValues containsObject:value])
        [self.likelyValues addObject:value];
}

- (NSString *)writableValue {
    return self.value.integerValue == 0 ? @"-" : [self.value stringValue];
}

@end
