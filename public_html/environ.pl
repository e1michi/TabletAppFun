#!/usr/local/bin/perl

$environ = 1;

$log_dir = 'logs';
$log_filename = 'taf.log';

@log_level_keys = ('error', 'warn', 'info', 'config', 'debug');
$log_level{$log_level_keys[0]} = '#ERR#';
$log_level{$log_level_keys[1]} = '#WRN#';
$log_level{$log_level_keys[2]} = '#INF#';
$log_level{$log_level_keys[3]} = '#CNF#';
$log_level{$log_level_keys[4]} = '#DBG#';

$logging = 4;

#
# データファイル操作関連
#
$data_dir      = 'data';
$data_file_ext = 'dat';
$field_sep     = '####<SEP>####';

$languages_data_file = 'languages';
$charges_data_file = 'charges';
$devices_data_file = 'devices';
$scenes_data_file = 'scenes';
$categories_data_file = 'categories';
$contents_data_file = 'contents';
