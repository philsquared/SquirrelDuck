#import "Squirrel.h"
#import "Duck.h"

#include "catch.hpp"

#include <objc/runtime.h>

// This function will get called when we send the "quack" message to Squirrel
// The first arg is the dynamic ref to the squirrel object (self, or this, if you prefer)
// The second arg is the handle to the selector (the objectification of the message/ method call - ie the thing that "selects" the method to call)
void nutQuacker(id squirrel, SEL selector) {
    NSLog( @"quacking %d nuts", [squirrel numberOfNuts] );
}

TEST_CASE("Squirrel") {
    
    id squirrel = [[Squirrel alloc] init];
    REQUIRE( [squirrel numberOfNuts] == 1 );

    SECTION("Gather and eat nuts") {
        [squirrel gatherNuts:4];
        REQUIRE([squirrel numberOfNuts] == 5);

        [squirrel eat];
        REQUIRE( [squirrel numberOfNuts] == 4 );

    }
    SECTION("Can message nil") {
        squirrel = nil;
        REQUIRE([squirrel numberOfNuts] == 0);
    }

    SECTION("Quack like a duck") {

        // Without the call to class_addMethod, this would throw an "unrecognized selector" exception
        // With the call, we're adding a method to the squirrel at runtime, so it now responds to the quack message
        class_addMethod([Squirrel class], @selector(quack), (IMP)nutQuacker, "v@:");
        [squirrel quack];
    }
}

@interface FakeSquirrel : NSObject
    // No public interface required
@end
@implementation FakeSquirrel
-(int) numberOfNuts {
    return 42;
}
@end

// This function just demonstrates that we can pass an object to something that expects a squirrel,
// send squirrely messages to it, and (as long as those methods are implemented) it will respond as expected
//  - even if it's not a squirrel
int nutCounter( Squirrel* squirrel ) {
    return [squirrel numberOfNuts];
}

TEST_CASE("nut counter") {
    // Not a squirrel
    id fakeSquirrel = [[FakeSquirrel alloc] init];

    // This only works because we made fakeSquirrel an id - but if we'd typed it as FakeSquirrel, we could still
    // cast it to Squirrel here and that would work, too
    REQUIRE( nutCounter(fakeSquirrel) == 42 );
}

// This fake will stand in for the Nuttery singleton, which the eat method of Squirrel uses
// to determine the number of nuts to eat. Same principle as with FakeSquirrel (as long as it implements the methods
// requested) - but the extra complication is that we want to return this when any code, which we don't own, requests
// the Nuttery singleton
@interface FakeNuttery : NSObject @end
@implementation FakeNuttery {
    int _nutsPerMouthful;
}
-(id) initWithNutsPerMouthful: (int) nuts {
    self = [super init];
    if( self != nil ) {
        _nutsPerMouthful = nuts;
    }
    return self;
}
-(int) nutsPerMouthful {
    return _nutsPerMouthful;
}
@end

#import "Nuttery.h"

// This is my separate library (included as source) for injecting singletons
#import "TBCSingletonInjector.h"

TEST_CASE("Utterly nuttery") {

    // Create the fake, as before
    id fake = [[FakeNuttery alloc] initWithNutsPerMouthful:3];

    // Get the injector to use method swizzling to swap the original implementation of the sharedInstance method on
    // Nuttery, with one that calls into the injector and returns our FakeNuttery.
    // It then calls us back on the passed in block, and afterwards restores the original methods
    [TBCSingletonInjector injectSingleton:fake intoClass:[Nuttery class] forSelector:@selector(sharedInstance) withBlock:^ {
        id squirrel = [[Squirrel alloc] init];
        [squirrel gatherNuts:4];
        [squirrel eat];
        REQUIRE( [squirrel numberOfNuts] == 2 );
    }];
}

