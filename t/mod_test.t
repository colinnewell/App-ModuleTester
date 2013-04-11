use Test::Most;

use ModuleTesting qw/read_issue_file/;

my @modules = read_issue_file('test_modules.txt');
eq_or_diff \@modules, [];

done_testing;
