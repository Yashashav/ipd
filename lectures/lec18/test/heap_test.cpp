#include "Binomial_heap.h"
#include <UnitTest++/UnitTest++.h>

using namespace ipd;

TEST(New_is_empty)
{
    Binomial_heap<int> h;
    CHECK(h.empty());
    CHECK_EQUAL(0, h.size());
}

TEST(Add_increases_size)
{
    Binomial_heap<int> h;

    h.add(5);
    CHECK(!h.empty());
    CHECK_EQUAL(1, h.size());

    h.add(6);
    CHECK(!h.empty());
    CHECK_EQUAL(2, h.size());
}

TEST(Add_changes_min)
{
    Binomial_heap<int> h;

    h.add(5);
    CHECK_EQUAL(5, h.get_min());

    h.add(6);
    CHECK_EQUAL(5, h.get_min());

    h.add(3);
    CHECK_EQUAL(3, h.get_min());

    h.add(1);
    CHECK_EQUAL(1, h.get_min());

    h.add(2);
    CHECK_EQUAL(1, h.get_min());
}

TEST(Remove_changes_min)
{
    Binomial_heap<int> h;

    h.add(5);
    h.add(6);
    h.add(7);
    h.add(8);
    h.add(9);
    h.add(10);

    CHECK_EQUAL(5, h.get_min());
    h.remove_min();
    CHECK_EQUAL(6, h.get_min());
    h.remove_min();
    CHECK_EQUAL(7, h.get_min());
    h.remove_min();
    CHECK_EQUAL(8, h.get_min());
    h.remove_min();
    CHECK_EQUAL(9, h.get_min());
    h.remove_min();
    CHECK_EQUAL(10, h.get_min());
    h.remove_min();
    CHECK(h.empty());
}