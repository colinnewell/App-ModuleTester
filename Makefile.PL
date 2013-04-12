use 5.006;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'App-ModuleTester';
all_from 'lib/App/ModuleTester.pm';
author   q{Colin Newell <colin.newell@gmail.com>};
license  'artistic2';

perl_version 5.006;

tests_recursive('t');

resources (
   #homepage   => 'http://yourwebsitehere.com',
   #IRC        => 'irc://irc.perl.org/#App-ModuleTester',
   license    => 'http://www.perlfoundation.org/artistic_license_2_0',
   #repository => 'git://github.com/Colin Newell/App-ModuleTester.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ModuleTester',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   'Modern::Perl' => 0,
   'Path::Tiny' => 0,
);
install_script 'bin/module-tester';
install_script 'bin/test-tarballs';

install_as_cpan;
auto_install;
WriteAll;
