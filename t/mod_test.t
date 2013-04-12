use Test::Most;

use FindBin;
use App::ModuleTester qw/read_issue_file get_tarball_name copy_latest_build modules_in_dir/;

my @modules = read_issue_file("$FindBin::Bin/test_modules.txt");
eq_or_diff \@modules, [qw/
Acme::Test::Weather
Apache::Test
Bundle::Test::SQL::Statement
CatalystX::Test::Recorder
Kwiki::Test
PITA::Test::Dummy::Perl5::Deps
Plack::Test::ExternalServer
/];

my $tarball = get_tarball_name("$FindBin::Bin/build.log");
is $tarball, "Term-ReadLine-Perl-1.0303.tar.gz";

my $path = "$FindBin::Bin/../../ToFix";
explain $path;
my @module_list = modules_in_dir($path);
explain \@module_list;

done_testing;
