use Test::Most;

use FindBin;
use App::ModuleTester qw/read_issue_file/;

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

done_testing;
