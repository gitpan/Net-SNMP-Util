use strict;
use warnings;
use Test::More tests => 4;

use Net::SNMP::Util::OID;	# no import group

my $oid_mgmt = '1.3.6.1.2';
my $oid_priv = '1.3.6.1.4';

subtest "check oid()" => sub {
	is(	oid("mgmt"),
		$oid_mgmt,
		qq/oid("mgmt") = "$oid_mgmt"/
	);
	is(	join("", oid("mgmt","private") ),
		"$oid_mgmt$oid_priv",
		qq/oid("mgmt", "private") = ("$oid_mgmt","$oid_priv")/
	);
	is(	oid("hoge"),
		"hoge",
		qq/oid("hoge") = "hoge"/
	);
	is(	oid("mgmt.1.2"),
		"$oid_mgmt.1.2",
		qq/oid("mgmt.1.2") = "$oid_mgmt.1.2"/
	);
	done_testing();
};

subtest "check oidt()" => sub {
	is(	oidt($oid_mgmt),
		"mgmt",
		qq/oidt("$oid_mgmt") = "mgmt"/
	);
	is(	join("", oidt($oid_mgmt, $oid_priv) ),
		"mgmtprivate",
		qq/oidt("$oid_mgmt", "$oid_priv") = ("mgmt","private")/
	);
	is(	oidt("1.2.3.4.5.6"),
		"",
		qq/oidt("1.2.3.4.5.6") = ""/
	);
	done_testing();
};

subtest "check oidp()" => sub {
	is(	join("", oidp("mgmt")),
		"mgmt$oid_mgmt",
		qq/oidp("mgmt") = ("mgmt","$oid_mgmt")/
	);
	is(	join("", oidp("mgmt.1.2")),
		"mgmt.1.2$oid_mgmt.1.2",
		qq/oidp("mgmt.1.2") = ("mgmt.1.2","$oid_mgmt.1.2")/
	);
	done_testing();
};


my %testmib = (
	myMib1 => "$oid_priv.1.999999.10.1",
	myMib2 => "$oid_priv.1.999999.10.2",
);
subtest "check oid_load()" => sub {
	my $myoid3 = "$oid_priv.1.999999.10.3";
	oid_load( \%testmib, "myMib3" => $myoid3 );
	$testmib{myMib3} = $myoid3;

	foreach ( 1..3 ){
		is(	oid("myMib$_"),
			$testmib{"myMib$_"},
			qq/oid("myMib$_") = "$testmib{"myMib$_"}"/
		);
		is(	oidt($testmib{"myMib$_"}),
			"myMib$_",
			qq/oidt($testmib{"myMib$_"}) = "myMib$_"/
		);
	}
	done_testing();
};


