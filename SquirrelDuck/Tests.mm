#import "Squirrel.h"
#import "Duck.h"

#include "catch.hpp"

TEST_CASE("Squirrel") {
    
    id squirrel = [[Squirrel alloc] init];
    REQUIRE( [squirrel numberOfNuts] == 1 );

    SECTION("Gather and eat nuts") {
        [squirrel gatherNuts:4];
        REQUIRE([squirrel numberOfNuts] == 5);

        [squirrel eat];
        REQUIRE([squirrel numberOfNuts] == 4);
    }

}
