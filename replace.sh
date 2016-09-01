LINE_NUMBER=$(sed -n '/(t8=lbv;t8<=ubv;t8++)/=' ./temp1.c)
head -n $(( $LINE_NUMBER - 1 )) temp1.c > temp2.c
printf "if(t5 %% 3 == 0) {" >> temp2.c
sed -n "$LINE_NUMBER,$(( $LINE_NUMBER + 2 ))p" temp1.c | sed 's/u\[t5+2\]/u\[2\]/g' | sed 's/u\[t5+1\]/u\[1\]/g' | sed 's/u\[t5\]/u\[0\]/g' >>temp2.c
printf "} else if(t5 %% 3 == 1) {\n" >> temp2.c
sed -n "$LINE_NUMBER,$(( $LINE_NUMBER + 2 ))p" temp1.c | sed 's/u\[t5+2\]/u\[0\]/g' | sed 's/u\[t5+1\]/u\[2\]/g' | sed 's/u\[t5\]/u\[1\]/g' >>temp2.c
printf "} else {\n" >> temp2.c
sed -n "$LINE_NUMBER,$(( $LINE_NUMBER + 2 ))p" temp1.c | sed 's/u\[t5+2\]/u\[1\]/g' | sed 's/u\[t5+1\]/u\[0\]/g' | sed 's/u\[t5\]/u\[2\]/g' >>temp2.c
printf "}" >> temp2.c
tail -n +$(( $LINE_NUMBER + 3 )) temp1.c >>temp2.c
