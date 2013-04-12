package App::ModuleTester;

use 5.006;
use strict;
use warnings FATAL => 'all';

=head1 NAME

App::ModuleTester - cpanm test a bunch of modules.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(read_issue_file get_tarball_name copy_latest_build main);

use Path::Tiny;


=head1 SYNOPSIS

This application allows multiple modules to be tested.

    use App::ModuleTester qw/main/;

    main(shift);

=head1 EXPORT

=head2 main

The whole command line program that loops through the
list of modules to test from the issue report and
runs cpan --test-only

=head2 copy_latest_build

Copy the most recent build log from the cpanm latest-build
directory.

=head2 copy_tarball

Copy the tarball specified from the cpanm latest build
directory to the current directory.

=head2 get_tarball_name

Extract the tarball name for the latest module tested
by cpanm from te logfile specified.

=head2 read_issue_file

Extract the list of modules to test from the issue 
text file specified.

=cut

sub read_issue_file
{
    my $filename = shift;
    my $path = path($filename);
    die "$filename does not exist" unless $path->exists;
    my $data = $path->slurp;
    my @modules = $data =~ /^(\w+(?:::\w+)*)$/mg;
}

sub copy_latest_build
{
    my $module_name = shift;
    my $fname = "$module_name-build.log";
    path("~/.cpanm/latest-build/build.log")->copy($fname);
    return $fname;
}

sub copy_tarball
{
    my $tarball = shift;
    path("~/.cpanm/latest-build/$tarball")->copy('.');
}

sub get_tarball_name
{
    my $log_file = shift;
    my $log_contents = path($log_file)->slurp;
    my ($tarball) = $log_contents =~ /^Unpacking (.*)$/m;
    return $tarball;
}

sub main
{
    my $issue_list = shift;
    die 'Must specify issue list' unless $issue_list;

    my @modules = read_issue_file($issue_list);
    for my $module (@modules)
    {
        system "cpanm --test-only $module";
        my $log = copy_latest_build($module);
        my $tarball = get_tarball_name($log);
        copy_tarball($tarball);
    }
}

=head1 AUTHOR

Colin Newell, C<< <colin.newell at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-moduletester at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ModuleTester>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ModuleTester


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ModuleTester>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ModuleTester>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ModuleTester>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ModuleTester/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Colin Newell.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of App::ModuleTester
