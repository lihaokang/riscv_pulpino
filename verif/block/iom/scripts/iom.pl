#!/usr/bin/perl

@fun0_i = (

scl_pad_o,
sda_pad_o,
uart_tx,
"1'b0",
"1'b0",
"1'b0",
"spi_mode_o[0]",
"spi_mode_o[1]",
spi_sdo0_o,
spi_sdo1_o,
spi_sdo2_o,
spi_sdo3_o,
scl1_pad_o,
sda1_pad_o,
uart1_tx,
"1'b0",
spi_master_clk_o,
spi_master_csn0_o,
spi_master_sdo0_o,
spi_master_sdo1_o,
scl2_pad_o,
sda2_pad_o,
uart2_tx,
"1'b0",
spi_master_csn1_o,
spi_master_csn2_o,
spi_master_csn3_o,
"spi_master_mode_o[0]",
"spi_master_mode_o[1]",
spi_master_sdo2_o,
spi_master_sdo3_o,
uart3_tx,
"1'b0",
uart4_tx,
"1'b0",


        
);  

@fun0_o = (

scl_pad_i,
sda_pad_i,
DUMMY,
uart_rx,
spi_clk_i,
spi_cs_i,
DUMMY,
DUMMY,
spi_sdi0_i,
spi_sdi1_i,
spi_sdi2_i,
spi_sdi3_i,
scl1_pad_i,
sda1_pad_i,
DUMMY,
uart1_rx,
DUMMY,
DUMMY,
spi_master_sdi0_i,
spi_master_sdi1_i,
scl2_pad_i,
sda2_pad_i,
DUMMY,
uart2_rx,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
spi_master_sdi2_i,
spi_master_sdi3_i,
DUMMY,
uart3_rx,
DUMMY,
uart4_rx,


);

@fun1_i = (


spi1_master_clk_o,
spi1_master_csn0_o,
spi1_master_sdo0_o,
spi1_master_sdo1_o,
scl3_pad_o,
sda3_pad_o,
scl4_pad_o,
sda4_pad_o,
uart5_tx,
"1'b0",
scl5_pad_o,
sda5_pad_o,
spi1_master_csn1_o,
spi1_master_csn2_o,
spi1_master_csn3_o,
"spi1_master_mode_o[0]",
DUMMY,
DUMMY,
DUMMY,
DUMMY,
"spi1_master_mode_o[1]",
spi1_master_sdo2_o,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
ANA_TOP_TP,
DUMMY,
DUMMY,
spi1_master_sdo3_o,
DUMMY,



);

@fun1_o = (

DUMMY,
DUMMY,
spi1_master_sdi0_i,
spi1_master_sdi1_i,
scl3_pad_i,
sda3_pad_i,
scl4_pad_i,
sda4_pad_i,
DUMMY,
uart5_rx,
scl5_pad_i,
sda5_pad_i,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
spi1_master_sdi2_i,
ADC_IN_7,
ADC_IN_6,
ADC_IN_5,
ADC_IN_4,
ADC_IN_3,
ADC_IN_2,
ADC_IN_1,
ADC_IN_0,
DUMMY,
ADC_VRP_EXT,
ADC_VRM_EXT,          
spi1_master_sdi3_i,
DUMMY,



);

@fun3_i = (


DUMMY,
DUMMY,
DUMMY,
o_sio_pad,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,




);

@fun3_o = (

i_smten_pad,
i_sce_pad,
sclk_pad,
i_sio_pad,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,
DUMMY,





);


&idio_io_assign;
#&idio_io_wire;
#&idio_io_inout;
#&idio_inst;


#&idio_test;


sub idio_io_assign{
#    for($fun0_i_idx = 0; $fun0_i_idx <= $#fun0_i; $fun0_i_idx++){
#        print "$fun0_i[$fun0_i_idx]\n";           
#    }
    $fun1_i_dout = "1'b0";
    $fun3_i_dout = "1'b0";
    for($pad_idx = 0; $pad_idx <= 31; $pad_idx++){
        $pad_dout_mode = "pad$pad_idx"."_mode";
        if(!($fun0_o[$pad_idx] eq "DUMMY")){
            print "\tassign $fun0_o[$pad_idx]\t= ($pad_dout_mode == 4'h0) ? pad_$pad_idx"."_din : 1'b0;\n";    
        }
        if(!($fun1_o[$pad_idx] eq "DUMMY")){
            print "\tassign $fun1_o[$pad_idx]\t= ($pad_dout_mode == 4'h1) ? pad_$pad_idx"."_din : 1'b0;\n";    
        }

        if(!($fun3_o[$pad_idx] eq "DUMMY")){
            print "\tassign $fun3_o[$pad_idx]\t= ($pad_dout_mode == 4'h3) ? pad_$pad_idx"."_din : 1'b0;\n";    
        }

        print "\tassign gpio_in[$pad_idx]\t= ($pad_dout_mode == 4'h2) ? pad_$pad_idx"."_din : 1'b0;\n";
        if($pad_idx < 10){
            print "\tassign pad_$pad_idx"."_od\t\t= od_cfg0[$pad_idx];\n"; 
        }
        else{
            print "\tassign pad_$pad_idx"."_od\t= od_cfg0[$pad_idx];\n"; 
        }
        #$substr = substr($fun0_i[$pad_idx], 0, 3);
        #print "substr: $substr\n";
        if(substr($fun0_i[$pad_idx], 0, 4) eq "scl1"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? scl1_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda1"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? sda1_padoen_o : eno_cfg0[$pad_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl2"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl2_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda2"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda2_padoen_o : eno_cfg0[$pad_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl3"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl3_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda3"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda3_padoen_o : ($pad_dout_mode == 4'h3) ? o_sio_oen_pad : eno_cfg0[$pad_idx];\n";#EFT    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl4"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl4_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda4"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda4_padoen_o : eno_cfg0[$pad_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl5"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl5_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda5"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda5_padoen_o : eno_cfg0[$pad_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 3) eq "scl"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? scl_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 3) eq "sda"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? sda_padoen_o : eno_cfg0[$pad_idx];\n";    
        }
        else{
            print "\tassign pad_$pad_idx"."_eno\t= eno_cfg0[$pad_idx];\n"; 
        }
        print "\tassign pad_$pad_idx"."_eni\t= eni_cfg0[$pad_idx];\n";    
        print "\tassign pad_$pad_idx"."_pu1\t= pu1_cfg0[$pad_idx];\n";    
        print "\tassign pad_$pad_idx"."_pu2\t= pu2_cfg0[$pad_idx];\n";
        if(!($fun1_i[$pad_idx] eq "DUMMY")){$fun1_i_dout = $fun1_i[$pad_idx];}
        if(!($fun3_i[$pad_idx] eq "DUMMY")){
            $fun3_i_dout = $fun3_i[$pad_idx];
            print "\tassign pad_$pad_idx"."_dout\t= ($pad_dout_mode == 4'h0) ? $fun0_i[$pad_idx] :\n\t\t\t\t\t\t($pad_dout_mode == 4'h1) ? $fun1_i_dout :\n\t\t\t\t\t\t($pad_dout_mode == 4'h2) ? gpio_out[$pad_idx]: \n\t\t\t\t\t\t($pad_dout_mode == 4'h3) ? $fun3_i_dout :1'b0;\n\n";
        }
        else{
            if(!($fun1_i[$pad_idx] eq "DUMMY")){
                print "\tassign pad_$pad_idx"."_dout\t= ($pad_dout_mode == 4'h0) ? $fun0_i[$pad_idx] :\n\t\t\t\t\t\t($pad_dout_mode == 4'h1) ? $fun1_i_dout :\n\t\t\t\t\t\t($pad_dout_mode == 4'h2) ? gpio_out[$pad_idx]: 1'b0;\n\n";
            }
            else{
                print "\tassign pad_$pad_idx"."_dout\t= ($pad_dout_mode == 4'h0) ? $fun0_i[$pad_idx] :\n\t\t\t\t\t\t($pad_dout_mode == 4'h2) ? gpio_out[$pad_idx]: 1'b0;\n\n";                
            }
        }
    }
    for($pad_idx = 32; $pad_idx <= 34; $pad_idx++){
        $cfg_idx = $pad_idx - 32;
        $pad_dout_mode = "pad$pad_idx"."_mode";
        if(!($fun0_o[$pad_idx] eq "DUMMY")){
            print "\tassign $fun0_o[$pad_idx]\t= ($pad_dout_mode == 4'h0) ? pad_$pad_idx"."_din : 1'b0;\n";    
        }
        if(!($fun1_o[$pad_idx] eq "DUMMY")){
            print "\tassign $fun1_o[$pad_idx]\t= ($pad_dout_mode == 4'h1) ? pad_$pad_idx"."_din : 1'b0;\n";    
        }
        print "\tassign gpio1_in[$cfg_idx]\t= ($pad_dout_mode == 4'h2) ? pad_$pad_idx"."_din : 1'b0;\n";
        print "\tassign pad_$pad_idx"."_od\t= od_cfg1[$cfg_idx];\n";            
        if(substr($fun0_i[$pad_idx], 0, 4) eq "scl1"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? scl1_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda1"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? sda1_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl2"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl2_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda2"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda2_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl3"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl3_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda3"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda3_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl4"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl4_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda4"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda4_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "scl5"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? scl5_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 4) eq "sda5"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h1) ? sda5_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }

        elsif(substr($fun0_i[$pad_idx], 0, 3) eq "scl"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? scl_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        elsif(substr($fun0_i[$pad_idx], 0, 3) eq "sda"){
            print "\tassign pad_$pad_idx"."_eno\t= ($pad_dout_mode == 4'h0) ? sda_padoen_o : eno_cfg1[$cfg_idx];\n";    
        }
        else{
            print "\tassign pad_$pad_idx"."_eno\t= eno_cfg1[$cfg_idx];\n"; 
        }
        print "\tassign pad_$pad_idx"."_eni\t= eni_cfg1[$cfg_idx];\n";    
        print "\tassign pad_$pad_idx"."_pu1\t= pu1_cfg1[$cfg_idx];\n";    
        print "\tassign pad_$pad_idx"."_pu2\t= pu2_cfg1[$cfg_idx];\n";    
        if(!($fun1_i[$pad_idx] eq "DUMMY")){
            $fun1_i_dout = $fun1_i[$pad_idx];
            print "\tassign pad_$pad_idx"."_dout\t= ($pad_dout_mode == 4'h0) ? $fun0_i[$pad_idx] :\n\t\t\t\t\t\t($pad_dout_mode == 4'h1) ? $fun1_i_dout :\n\t\t\t\t\t\t($pad_dout_mode == 4'h2) ? gpio1_out[$cfg_idx]: 1'b0;\n\n";           
        }
        else{
            print "\tassign pad_$pad_idx"."_dout\t= ($pad_dout_mode == 4'h0) ? $fun0_i[$pad_idx] :\n\t\t\t\t\t\t($pad_dout_mode == 4'h2) ? gpio1_out[$cfg_idx]: 1'b0;\n\n";                       
        }
    }
}

sub idio_io_wire{
    for($pad_idx = 0; $pad_idx <= 34; $pad_idx++){
        print "\twire pad_$pad_idx"."_od\t;\n";    
        print "\twire pad_$pad_idx"."_eno\t;\n";    
        print "\twire pad_$pad_idx"."_eni\t;\n";    
        print "\twire pad_$pad_idx"."_din\t;\n";    
        print "\twire pad_$pad_idx"."_pu1\t;\n";    
        print "\twire pad_$pad_idx"."_pu2\t;\n";    
        print "\twire pad_$pad_idx"."_dout;\n\n";    
    }
}

sub idio_io_inout{
    for($pad_idx = 0; $pad_idx <= 34; $pad_idx++){
        print "\tinout wire pad_$pad_idx"."_spad\t,\n";    
    }
}

sub idio_inst{
    for($pad_idx = 0; $pad_idx <= 34; $pad_idx++){
        print "\tIDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_$pad_idx(\n";
        print "\t\t.OD\t\t(pad_$pad_idx"."_od\t),\n";    
        print "\t\t.ENO\t(pad_$pad_idx"."_eno\t),\n";    
        print "\t\t.ENI\t(pad_$pad_idx"."_eni\t),\n";    
        print "\t\t.DIN\t(pad_$pad_idx"."_din\t),\n";    
        print "\t\t.PU1\t(pad_$pad_idx"."_pu1\t),\n";    
        print "\t\t.PU2\t(pad_$pad_idx"."_pu2\t),\n";    
        print "\t\t.DOUT\t(pad_$pad_idx"."_dout\t),\n";    
        print "\t\t.SPAD\t(pad_$pad_idx"."_spad\t),\n";    
        
        print "\t\t.VCC\t(VCC\t\t),\n";    
        print "\t\t.VDD\t(VDD\t\t),\n";    
        print "\t\t.GND\t(GND\t\t)\n";    
        print "\t);\n\n";    
    }
}


