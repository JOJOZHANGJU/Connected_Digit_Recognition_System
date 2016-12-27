use strict;
#open(ifile,"1.textgrid") or die;
#open(ofile,"> logo.txt") or die;
#print ofile <ifile>;
#close(ifile);
#close(ofile);
my($dir) = @ARGV;
chdir $dir or die"cannot chdir :$!" if($dir); #进入程序所在文件夹中的子文件夹$dir#
my @tempfile =(glob"*.textgrid");
my $i;
my @nfilename ;
my @tempfile1 =(glob"*.textgrid");
@nfilename =grep{s/textgrid$/lab/ig,$_} @tempfile1;
for($i=0;$i< @tempfile; $i++){
my $openfile =$tempfile[$i];
open(ifile,$tempfile[$i]) or die "$!";
my @file;
while(<ifile>){
    if(/item \[1\]/../item \[2\]/){
      push@file,$_;
    }
}
close(ifile);
my @file1;
foreach(@file){
  if(/intervals \[1\]/../item \[2\]/){
    push@file1,$_;
  }
}
@file=();
foreach(@file1){
  if(/xmin/../text/g){
   push@file,$_;
  # print ofile $_;
  }
}
@file1=();
@file1 =grep{s/xmin =|xmax =| text =|"|"//g,$_} @file;
@file=();
@file =grep{s/^\s+|\s+$/ /g,$_} @file1;
my $newfile =$nfilename[$i];
mkdir "lab";
open(ofile,"> lab/$newfile") or die;
my $index=1;
foreach(@file){
  if($index%3){
    print ofile "$_\t";
    
  }else{
   print ofile "$_\n";
  }
  $index++;
}
close(ofile);
}
print "共处理完成$i个文档，请进入lab文档查看结果！";