#!/usr/bin/perl -w
#version 1.4.1
#2013-05-15
#hdh@amazon.com

use strict;
use warnings;
use constant DEBUG=>1;

use LWP::UserAgent;
use HTTP::Request;
use XML::Simple;
use Data::Dumper;
use JSON;
use URI::Escape;
use List::Util qw[min max];
use Time::HiRes qw[usleep];
use POSIX qw(strftime);

my $cur_hour = int(strftime("%H", localtime));
my $cur_min = int(strftime("%M", localtime));
my $request_count = int(rand(50));

$request_count = int(600*(0.5* (cos(($cur_hour*60 + $cur_min )*3.1415/720.0)+1))) + $request_count;


my @user_agents = qw( iOS Android Other );
my $url = "http://cloudwatch-demo.elasticbeanstalk.com";
my $agent = LWP::UserAgent->new(env_proxy=>1, keep_alive=>1, timeout=>30);

my $header = HTTP::Request->new(GET=> $url);
my $request = HTTP::Request->new("GET", $url, $header);
my $response = "test";

for(my $i=0; $i<$request_count; $i++)
{
#       $agent->_agent = $user_agents[int(rand(2))].$agent->_agent;
        $response = $agent->request($request);
        usleep((int(rand(200))+50)*1000);
}

#print $response->is_success."\n";
#print $response->code."\n";
#print $response->content."\n";
