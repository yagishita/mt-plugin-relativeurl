## Copyright (c) 2016 Taketoshi Yagishita

package RelativeUrl::Tags;

use strict;
use warnings;

sub _hdlr_relativeurl {
    my ( $text, $arg, $ctx ) = @_;

    ## check parameter
    return $text unless $arg;

    my $blog = $ctx->stash('blog');
    return $text unless $blog;

    ## domain
    my $domain = $blog->site_url;
    if ( $domain =~ m|^https?://([^/:]+)(:\d+)?/?| ) {
        $domain = $1 . ( $2 || '' );
    }

    ## filter
    if ( $arg == 1 ) {
        $text =~ s|https?://$domain||g;
    }
    elsif ( $arg == 2 ) {
        ## absolute-path reference
        $text =~ s|(<[^>]+href=")https?://$domain|$1|g;
        $text =~ s|(<[^>]+src=")https?://$domain|$1|g;

        ## network-path reference
        $text =~ s|(<[^>]+src=")https?:|$1|g;
    }
    return $text;
}

1;
