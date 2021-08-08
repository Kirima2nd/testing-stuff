/*
*    Testing Stuff
*    Author: Kirima2nd
*
*    About:
*    It's just a testing for my projects
*    You can use it though and edit it by yourself
*/

// NEVER remove this, it's good for making your warning becomes error!
#pragma option -E

/*  
    ----------------------------------------------------
    Initializing Resources
    ----------------------------------------------------
    If your code requires some specific library
    (let's say ssscanf) then you'll need to put the
    include after `#inclue <YSI_Core\y_testing>`.
    ----------------------------------------------------
*/
#include <a_samp>

// Testing include, NEVER REMOVE THIS!!!
#define RUN_TESTS
#include <YSI_Core\y_testing>

/*  
    ----------------------------------------------------
    Preparing your code
    ----------------------------------------------------
    Put your stuff above TEST__ or PTEST__ because
    when you put your code below it can cause an error
    like `forcing reparse` or `undefined symbol`
    ----------------------------------------------------
*/
enum e_SOMETHING(<<=1)
{
    E_ONE = 1,
    E_TWO,
    E_THREE,
    E_FOUR,
    E_FIVE,
    E_SIX,
    E_SEVEN,
    E_EIGHT,
    E_NINE,
    E_TEN,
    E_ELEVEN
};

e_SOMETHING:CallMe()
{
    new bitTest = 0, bool:testToggle;

    EmulateToggle(testToggle);
    bitTest = _:testToggle;

    for (new i  = 1; i != 11; i ++)
    {
        EmulateToggle(testToggle);
        bitTest = _:(bitTest << 1) | _:testToggle;
    }
    return e_SOMETHING:bitTest;
}

EmulateToggle(&bool:toggle)
{
    static emulateFalse = 0;

    if (++ emulateFalse > 3)
    {
        emulateFalse = 0;
        toggle = false;
    }
    else
    {
        toggle = true;
    }
}

/*  
    ----------------------------------------------------
    Entry Index
    ----------------------------------------------------
    This is entry index or as we call it `main code`
    if you're not declaring this, there is a chance you
    will get error in runtime.
    ----------------------------------------------------
*/
main()
{
    printf("Running Test...");
}

/*  
    ----------------------------------------------------
    Tutorial Testing
    ----------------------------------------------------
    This is how you supposed to test the code.
    It's either using TEST__ or Test:
    You can also test player using PTEST__ or PTest:
    ----------------------------------------------------
*/
TEST__ BitFlagsTest_1()
{
    new 
        e_SOMETHING:bitFlags = CallMe();

    TEST_REPORT("BitFlags #1: %0b", _:bitFlags);
    ASSERT(bool:(bitFlags & (E_ONE | E_TWO | E_THREE | E_FIVE | E_SIX | E_SEVEN | E_NINE | E_TEN | E_ELEVEN)));

    TEST_REPORT("BitFlags #2: %0b", _:(CallMe() & E_ONE | E_THREE));
    ASSERT(bool:(bitFlags & E_ONE | E_THREE));
}

TEST__ BitFlagsTest_2()
{
    new myArray[e_SOMETHING] = "Hello World";
    TEST_REPORT("Result #1: %d | %d | %d | %s", e_SOMETHING, _:e_SOMETHING / 4 + 1, sizeof(myArray), myArray);

    #define Bit_Count(%0) (floatround(floatlog(float(%0), 2.0)))
    TEST_REPORT("Result #2: %d | %d | %d", e_SOMETHING, Bit_Count(_:e_SOMETHING), _:e_SOMETHING / 4);
}

/*  
    ----------------------------------------------------
    Preparing a test code
    ----------------------------------------------------
    You can use TEST_INIT__ or PTEST_INIT__ to prepare
    the values and using TEST_CLOSE__ or PTEST_CLOSE__
    to cleanup the values.

    Here is the example of how you should doing the
    test using TEST_INIT__ and TEST_CLOSE__
    ----------------------------------------------------
*/
new 
    gPlayerId,
    e_SOMETHING:gTestPermissions[MAX_PLAYERS];

TEST_INIT__ CheckPermissions()
{
    TEST_REPORT("Preparing the values...");

    gPlayerId = 4;
    gTestPermissions[gPlayerId] = E_ONE | E_THREE | E_FIVE;
}

TEST__ CheckPermissions()
{
    ASSERT_TRUE(bool:_:(gTestPermissions[gPlayerId] & (E_ONE | E_FIVE)));
    TEST_REPORT("gTestPermissions[%d] = %0b", gPlayerId, _:gTestPermissions[gPlayerId]);
}

TEST_CLOSE__ CheckPermissions()
{
    TEST_REPORT("Clearing permissions!");
    gTestPermissions[gPlayerId] = e_SOMETHING:0;
    gPlayerId = -1;
}
