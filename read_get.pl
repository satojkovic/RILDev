#!perl

use strict;
use warnings;

use Config::Pit;
use WebService::Simple;

my $conf = pit_get("readitlater.com", require => {
    "APIKey" => "API key on readitlater.com",
    "username" => "your username on readitlater.com",
    "password" => "your password on readitlater.com"
});

my $service = WebService::Simple->new(
    base_url => 'https://readitlaterlist.com/v2/get',
    param => { apikey => "$conf->{APIKey}",
               username => "$conf->{username}",
               password => "$conf->{password}"
           },
    response_parser => 'JSON'
);

my $res = $service->get( { state => 'read' } );
my $json = $res->parse_response;
my $read_num = keys $json->{list};
print "Read $read_num items.\n";

