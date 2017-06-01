
#import <Foundation/Foundation.h>


@interface Position : NSObject<NSCopying>

+ (NSComparator) comparator;

- (instancetype) initializeWithX: (NSUInteger) x Y: (NSUInteger) y;

- (NSMutableArray*) shuffleTeam: (NSMutableArray*) arr;

- (void) remove: (id) value;
- (void) add: (id) value;

@property NSNumber * value;

@property (readonly) NSString* writableValue;

@property NSUInteger x, y;

@property bool temporary;

@property NSMutableArray* likelyValues;

@end
