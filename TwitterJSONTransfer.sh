#  Created by Takeo Katsuki on 3/16/15.
#  Copyright (c) 2015 Takeo Katsuki. All rights reserved.

ssh -i ~/.ssh/NUPMTwitter.pem ubuntu@ec2-54-67-37-214.us-west-1.compute.amazonaws.com "ls /home/rstudio | grep json" > ~/NUPMTwitter/jsonlist.txt
filename=(`cat ~/NUPMTwitter/jsonlist.txt`)
arrlen=`expr ${#filename[@]} - 2`
if ((arrlen < 0))
then
echo "Time: $(date)" >> ~/NUPMTwitter/transfer.log
echo "There are less than two files. File transfer skipped." >> ~/NUPMTwitter/transfer.log
else
for i in `seq 0 $arrlen`
do
echo ${filename[i]} >> ~/NUPMTwitter/transfer.log
scp -i ~/.ssh/NUPMTwitter.pem ubuntu@ec2-54-67-37-214.us-west-1.compute.amazonaws.com:/home/rstudio/${filename[i]} ~/NUPMTwitter/
if (($? != 0))
then
echo "scp failed" >> ~/NUPMTwitter/transfer.log
# insert some notification method
else
echo "scp succeeded" >> ~/NUPMTwitter/transfer.log
ssh -i ~/.ssh/NUPMTwitter.pem ubuntu@ec2-54-67-37-214.us-west-1.compute.amazonaws.com sudo rm /home/rstudio/${filename[i]}
fi
done
fi

