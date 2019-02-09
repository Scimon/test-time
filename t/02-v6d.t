use v6.d;

use Test;
use Test::Time;

subtest {
    plan 3;
    $*SCHEDULER = mock-time;
    my $p2 = Promise.new;
    my $p = start {
        my $start = now;
        pass "before";
        $p2.keep;
        sleep 50;
        pass "after";
        cmp-ok now - $start, ">=", 50;
    }

    await $p2;
    $*SCHEDULER.advance-by: 50;
    await $p;
}

done-testing;
