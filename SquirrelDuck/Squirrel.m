#import "Squirrel.h"
#import "Nuttery.h"

@implementation Squirrel {
    int squirrelNumber;
    int numberOfNuts;
}

@synthesize numberOfNuts;

-(id) init {
    self = [super init];
    if( self != nil ) {
        static int s_squirrelNumber = 0;
        squirrelNumber = ++s_squirrelNumber;
        numberOfNuts = 1;
    }
    return self;
}
-(void) dealloc {
    NSLog( @"squirrel %d is deceased", squirrelNumber );
}

-(void) scamper {
    NSLog( @"scampering" );
}

-(void) gatherNuts:(int)numberOfNewNuts {
    numberOfNuts += numberOfNewNuts;
    NSLog( @"Gathered %d nut(s), now have %d", numberOfNewNuts, numberOfNuts );
}

-(void) eat {
    int nutsPerMouthful = [[Nuttery sharedInstance] nutsPerMouthful];
    numberOfNuts -= nutsPerMouthful;
    NSLog( @"eating %d nut(s), %d remaining", nutsPerMouthful, numberOfNuts );
}

@end
