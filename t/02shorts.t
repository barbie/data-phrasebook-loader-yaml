#!/usr/bin/perl -w
use strict;
use lib 't';
use BookDB;

use Test::More tests => 5;

# ------------------------------------------------------------------------

my $class = 'Data::Phrasebook';
use_ok $class;

my $file = 't/02phrases.yaml';

# ------------------------------------------------------------------------

{
    my $dbh = BookDB->new();

    my $obj = $class->new(
        class  => 'SQL',
        dbh    => $dbh,
		loader => 'YAML',
        file   => $file,
    );

    my ($count) = $obj
        ->query( 'count_author', {
                author => 'Lawrence Miles'
            } )
        ->fetchrow_array;

    is( $count => 7, "Quick Miles" );
}

{
    my $dbh = BookDB->new();

    my $obj = $class->new(
        class  => 'SQL',
        dbh    => $dbh,
		loader => 'YAML',
        file   => $file,
    );

    my $author = 'Lawrence Miles';
    my $q = $obj->query( 'find_author' );
    isa_ok( $q => 'Data::Phrasebook::SQL::Query' );

    # Slow
    {
        my $count = 0;
        $q->execute( author => $author );
        while ( my $row = $q->fetchrow_hashref )
        {
            $count++ if $row->{author} eq $author;
        }
        is( $count => 7, "row by row Miles" );
        $q->finish;
    }

    # fetchall_arrayref
    {
        my $count = 0;
        $q->execute( author => $author );
        my $r = $q->fetchall_arrayref;
        is ( scalar @$r => 7, "fetchall Miles" );
        $q->finish;
    }
}
