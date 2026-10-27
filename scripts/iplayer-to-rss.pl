#!/usr/bin/env perl

use strict;
use warnings;

use WWW::Curl::Easy;
use HTML::TreeBuilder;
use XML::RSS;

my ($feed_id) = @ARGV;
if (not defined $feed_id) {
	die;
}

my $feed_link = 'https://www.bbc.co.uk/programmes/' . $feed_id . '/episodes/player';

my $curl = WWW::Curl::Easy->new;
$curl->setopt(CURLOPT_HEADER,1);
$curl->setopt(CURLOPT_URL, $feed_link);

my $response_body;
$curl->setopt(CURLOPT_WRITEDATA, \$response_body);

if ($curl->perform != 0) {
	die;
}

my $tree = HTML::TreeBuilder->new;
$tree->parse($response_body) or die;

my $rss = XML::RSS->new(version => '2.0', encoding => 'UTF-8');
$rss->channel(
	title => $tree->look_down('class' => qr/\bbr-masthead__title\b/)->as_text,
	link => $feed_link,
	description => 'iPlayer RSS feed generated from ' . $feed_link,
);

my @episodes = $tree->look_down('class' => qr/\bprogramme\b/, 'data-pid' => qr/./);
foreach my $episode (@episodes) {
	my $id = $episode->attr('data-pid');
	my $title = $episode->look_down('class' => qr/\bprogramme__title\b/)->as_text;
	my $subtitle = $episode->look_down('class' => qr/\bprogramme__subtitle\b/)->as_text;
	my $synopsis = $episode->look_down('class' => qr/\bprogramme__synopsis\b/)->as_text;
	my $link = 'https://www.bbc.co.uk/programmes/' . $id;

	$rss->add_item(
		title => $title . ' - ' . $subtitle,
		description => $synopsis,
		link => $link,
		guid => "iplayer:" . $link,
	)
}

print $rss->as_string;
