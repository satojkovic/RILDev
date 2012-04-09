#!perl

use strict;
use warnings;

use Config::Pit;
use WebService::Simple;
use Encode;
use URI::Title;
use Data::Dumper;

my $uri = $ARGV[0];
if( @ARGV != 1 ) { die "Please specify the URL"; }

my $title = URI::Title::title($uri);
if( !defined($title) ) { $title = "new page"; }

my $conf = pit_get("readitlater.com", require => {
    "APIKey" => "API key on readitlater.com",
    "username" => "your username on readitlater.com",
    "password" => "your password on readitlater.com"
});

my $service = WebService::Simple->new(
    base_url => 'https://readitlaterlist.com/v2/',
    param => { apikey => "$conf->{APIKey}",
               username => "$conf->{username}",
               password => "$conf->{password}"
           },
);

my $res = $service->get("add", { url => $uri, title => $title });
if( $res->is_success ) {
    print $res->content . "\n";
}
else {
    print $res->status_line;;
}
