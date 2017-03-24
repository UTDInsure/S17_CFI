
  

[ -d splitStrip ] || mkdir splitStrip
cd splitStrip

for filename in ../J*
do
  csplit -n5 -s --prefix=${filename##*/} $filename "/========/+1" "{*}" #change to gcsplit on MacOS
done
for filename in ../C*
do
  csplit -n5 -s --prefix=${filename##*/} $filename "/========/+1" "{*}" #change to gcsplit on MacOS
done
