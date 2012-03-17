#!perl

use strict;
use warnings;

use Config::Pit;
use YAML;
use WebService::Simple;
use Encode;

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
warn Dump $res->parse_response;
