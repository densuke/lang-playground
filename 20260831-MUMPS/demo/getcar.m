getcar ; 別のプロセスから読み出す。添字は自動で並んでいる
 zwrite ^Car
 write "door color: ",^Car("Door","Color"),!
 new key set key=""
 for  set key=$order(^Car("Door",key)) quit:key=""  write "  ",key," = ",^Car("Door",key),!
 quit
