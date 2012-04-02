#!perl

use strict;
use warnings;

use Config::Pit;
use WebService::Simple;
use utf8;
use Encode;

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
    response_parser => 'JSON'
);

my $res = $service->get( "get", { state => "unread" } );
my $json = $res->parse_response;

my $now = time();
my $expired_count = 1;
foreach my $key (keys $json->{list}) {
    if( $now - 86400*7 > $json->{list}->{$key}->{time_added} ) {
        print "[$expired_count]" . encode("utf8", $json->{list}->{$key}->{title}) . "\n";
        $expired_count++;
    }
}


