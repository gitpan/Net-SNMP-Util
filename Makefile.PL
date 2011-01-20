use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::SNMP::Util',
    AUTHOR              => q{t.onodera <ong@garakuta.net>},
    VERSION_FROM        => 'lib/Net/SNMP/Util.pm',
    ABSTRACT_FROM       => 'lib/Net/SNMP/Util.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    NO_META             => 1,
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-SNMP-Util-*' },
);
