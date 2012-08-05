#!/usr/local/bin/perl

require 'cgi.pl';
require 'admin_cgi.pl';

# ヘッダ処理
write_http_header();

# リクエスト解析処理
parse_cgi_requrest();
exit;

# コンテンツヘッダ処理
write_content_header();

# アクション実行

# コンテンツフッタ処理
write_content_footer();
