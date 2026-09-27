setcar ; ^ で始まる名前 (グローバル変数) に入れると、データベースに残る
 SET ^Car("Engine")="V6"
 SET ^Car("Door","Count")=4
 SET ^Car("Door","Color")="BLUE"
 write "saved",!
 quit
