#!/usr/bin/env node

// append module
module.paths.push('/usr/lib/node_modules');

// load shell
var shell = require('shelljs');

var sim_filelist = shell.env["SIM_FILELIST"]
console.log(sim_filelist)

var lineReader = require('readline').createInterface({
  input: require('fs').createReadStream(sim_filelist)
});

// output file list for synthesis
shell.exec('rm -f vlog_filelist_synthesis.f')
var syn_filelist = require('fs')
  .createWriteStream("vlog_filelist_synthesis.f", {
    flags: 'a'
  });

// output search path for synthesis
shell.exec('rm -f vlog_search_path_synthesis.f')
var syn_search_path = require('fs')
  .createWriteStream("vlog_search_path_synthesis.f", {
    flags: 'a'
  });

// output search path for spyglass
shell.exec('rm -f vlog_filelist_spg.f')
var sg_filelist = require('fs')
  .createWriteStream("vlog_filelist_spg.f", {
    flags: 'a'
  });

// ignore comment line and testbenches
var regex_comment_line = /^\s*\/\//;
var regex_tb_dir = /\$tbDir/gi;
var regex_rtl_dir = /\$rtlDir/gi;
var regex_ips_dir = /\$ipsDir/gi;
var regex_inc_dir = /^\s*\+incdir\+/gi;
var regex_tbs = /tb_/gi;
var regex_verif = /\/verif\//gi
lineReader.on('line', function (line) {
  if (line.match(regex_tbs) || line.match(regex_verif)) {
    return;
  }
  // dump verilog file
  if (line.match(regex_inc_dir) &&
    !line.match(regex_tb_dir)) {
    line = line.replace(regex_ips_dir, shell.env["IPS_DIR"]);
    line = line.replace(regex_rtl_dir, shell.env["RTL_DIR"]);
    sg_filelist.write(line + '\n');
    line = line.replace(regex_inc_dir, '');
    syn_search_path.write(line + '\n');
    return;
  }
  if (!line.match(regex_comment_line) &&
    !line.match(regex_tb_dir)) {
    line = line.replace(regex_ips_dir, shell.env["IPS_DIR"]);
    line = line.replace(regex_rtl_dir, shell.env["RTL_DIR"]);
    syn_filelist.write(line + '\n');
    sg_filelist.write(line + '\n');
  }
});