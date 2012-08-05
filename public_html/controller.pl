#!/usr/local/bin/perl

#use mvc;

# ヘッダ処理
write_http_header();

# リクエスト解析処理
analyze_cgi_request();

# コンテンツヘッダ処理
write_content_header();

# アクション実行

# コンテンツフッタ処理
write_content_footer();

sub write_http_header() {
	print "Content-type: text/html\n";
	print "\n";
}
