#import <Foundation/Foundation.h>

@interface Squirrel : NSObject;

-(id) init;
-(void) dealloc;

-(void) scamper;
-(void) eat;
-(void) gatherNuts: (int) numberOfNewNuts;

@property (nonatomic, readonly) int numberOfNuts;

@end

