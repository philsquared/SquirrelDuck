#import "Duck.h"

@implementation Duck

-(id) init {
    self = [super init];
    if( self != nil ) {
        // do anything else to set up the duck
    }
    return self;
}

-(void) walk {
    NSLog( @"Waddle, waddle" );
}

-(void) quack {
    NSLog( @"Quack, quack" );
}

@end
