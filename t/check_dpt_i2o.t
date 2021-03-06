#!/usr/bin/perl
BEGIN {
	(my $srcdir = $0) =~ s,/[^/]+$,/,;
	unshift @INC, $srcdir;
}

use strict;
use warnings;
use Test::More tests => 5;
use test;

my @tests = (
	{
		status => OK,
		proc => 'dpt_i2o',
		entry => 'dpt_i2o/$controller',
		message => '0,0,0:online, 0,5,0:online, 0,6,0:online',
	},
);

foreach my $test (@tests) {
my $plugin = dpt_i2o->new(
		commands => {
			'proc' => ['<', TESTDIR . '/data/' .$test->{proc} ],
			'proc entry' => ['<', TESTDIR . '/data/' .$test->{entry} ],
		},
	);
	ok($plugin, "plugin created");

	$plugin->check;
	ok(1, "check ran");

	ok(defined($plugin->status), "status code set");
	ok($plugin->status == $test->{status}, "status code (got:".$plugin->status." exp:".$test->{status}.")");

	print "[".$plugin->message."]\n";
	ok($plugin->message eq $test->{message}, "status message");
}
