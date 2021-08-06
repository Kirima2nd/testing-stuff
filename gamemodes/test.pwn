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

// Include core
#include <a_samp>
#include <a_mysql>

// For testing, i use y_testing because it's easier.
#define RUN_TESTS
#include <YSI_Core\y_testing>

#include <YSI_Extra\y_inline_mysql>

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

Func(min, max = cellmax) {static i; return ((i!=max)?(i==0)?(i=min,printf("Increment: %i",i),Func(min,max)):((i!=max)?(i++,printf("Increment: %i",i),Func(min,max)):(max,printf("Already MAX!"))):(printf("Already MAX!")));}

// Main(), required or else will give error.
main()
{
    printf("Running Test...");
}

/*  
    ----------------------------------------------------
    Testing Your Code Below
    ----------------------------------------------------
    This is how you supposed to test the code.
    It's either using TEST__ or Test:
    You can also test player using PTEST__ or PTest:
    ----------------------------------------------------
*/

#if 0
// Your testing code should be like this
TEST__ TestName()
{
    // Code Below
}

// Or this
PTEST__ PlayerTestName(playerid)
{
    // Code below
    ASK("Ask about the test result like, \"Is it working?\"");
}

#endif

// This is my test code
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

TEST__ ShitFunc()
{
    Func(1, 10);
}

new MySQL:gHandle;

ReturnQuery()
{
    inline _OnSomething()
    {
        new ret = cache_num_rows();
        @return ret;
    }
    MySQL_TQueryInline(gHandle, using inline _OnSomething, "SELECT * FROM accounts");
    return 4;
}

ReturnQuery_2()
{
    inline _OnSomething_2()
    {
        new ret = cache_num_rows();
        return ret;
    }
    MySQL_TQueryInline(gHandle, using inline _OnSomething_2, "SELECT * FROM accounts");
    return 4;
}


ReturnQuery_3()
{
    inline const _OnSomething_3()
    {
        new ret = cache_num_rows();
        @return ret;
    }
    MySQL_TQueryInline(gHandle, using inline _OnSomething_3, "SELECT * FROM accounts");
    return 4;
}

ReturnQuery_4()
{
    new ret;
    inline _OnSomething_4()
    {
        cache_get_row_count(ret);
    }
    MySQL_TQueryInline(gHandle, using inline _OnSomething_4, "SELECT * FROM accounts");
    return ret;
}


public OnGameModeInit()
{
    gHandle = mysql_connect("localhost", "root", "", "wjcnr_rebuild");
}

TEST__ TestRetriveThing()
{
    ASSERT_NE(gHandle, MYSQL_INVALID_HANDLE);
    ASSERT_ZE(mysql_errno(gHandle));

    TEST_REPORT("Result Query #1: %d | %d", ReturnQuery(), ReturnQuery());
}

TEST__ TestRetriveThing_2()
{
    ASSERT_NE(gHandle, MYSQL_INVALID_HANDLE);
    ASSERT_ZE(mysql_errno(gHandle));

    TEST_REPORT("Result Query #2: %d | %d", ReturnQuery_2(), ReturnQuery_2());
}

TEST__ TestRetriveThing_3()
{
    ASSERT_NE(gHandle, MYSQL_INVALID_HANDLE);
    ASSERT_ZE(mysql_errno(gHandle));

    TEST_REPORT("Result Query #3: %d | %d", ReturnQuery_3(), ReturnQuery_3());
}

TEST__ TestRetriveThing_4()
{
    ASSERT_NE(gHandle, MYSQL_INVALID_HANDLE);
    ASSERT_ZE(mysql_errno(gHandle));

    TEST_REPORT("Result Query #4: %d | %d", ReturnQuery_4(), ReturnQuery_4());
}
