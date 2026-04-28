#!/bin/bash
#will use this tools: useradd , usermod ,chage,passwd,userdel,id,groups
#echo "Normal Users:"
#awk -F: '$3 >= 1000 {print $1}' /etc/passwd
return_menu(){
while true; do

        clear
        sleep 0.5
        echo "===Main Menu====="
        echo "1.Modify users"
        echo "2.Exit"
        read -p "choose: " choose
        case $choose in
                1|modify|users|Modify|users|modify|Users|y|Y|yes|Yes)
                        user_menu
                        break;;
                2|Exit|exit|exit|n|N|out)
                        exit 0
                        break;;
                *)
                        echo "please enter vaild answer"
                        sleep 0.5;;
                esac
        done
}
user_menu(){
while true; do
	clear
	sleep 0.5
	echo "======User Menu======"
	echo "0.back to main menu"
	echo "1.create users"
	echo "2.delete users"
	echo "3.set limit to user password"
	echo "4.change user passwd"
	echo "5.add user to group"
	echo "6.remove user from group"
	echo "7.get info about user"
	echo "8.show all normal users"
	read -p "choose: " main_menu
	case $main_menu in
		0)
			return_menu;;
		1)
			create_users
			break;;
		2)
			delete_users;;
		3)
			set_limit_to_user_paswd;;
		4)
			change_user_passwd;;
		5)
			add_user_to_group;;
		6)
			remove_user_from_group;;
		7)
			get_info;;
		8)
			all_users;;	
	        *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
done
}
create_users(){
while true; do
	clear
	sleep 0.5
	echo "========Create Users======"
	echo "0.back to user menu"
	echo "1.create simple user"
	echo "2.create specific user"
	read -p "choose the user name: " create_user
	case $create_user in
		0)
			user_menu;;
		1)
			echo "=============="
			read -p "enter username: " name
			sudo useradd -m -s /bin/bash --badname $name;;
		2)

			echo "=============="
			read -p "enter username: " name
			sudo useradd -m --badname $name
			echo "========"
	        	echo "choose shell"
       			echo "bash shell"
        		echo "sh sheel"
        		echo "zsh shell"
			read -p "choose: " shell;;
		*)
                        echo "Invalid choice"
                        sleep 0.3;;

		esac
	case $shell in
		1|bash)
			sudo usermod -b -s /bin/bash $name;;
		2|sh)

			sudo usermod -b -s /bin/sh $name;;
		3|zsh)
			sudo usermod -b -s /bin/zsh $name;;
	        *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
	echo "choose a password for new user" 
	sudo passwd $name
done
}
delete_users(){
while true; do
	clear
	sleep 0.5
	echo "=========Delete Users========="
	echo "0.back to user menu"
	echo "1.full delete"
	echo "2.specific delete"
	read -p "choose: " user_menu
	case $user_menu in

		0)

			user_menu;;
		1)
			echo "=============all users you have==========="
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			echo "NOTE: TYPE THE NAME OF USER OR UUID"
			read -p "please choose user to delete: " delete
			read -p "are you sure you want to delete this user will delete the file directory and all things Y/n: " choose;;
		2)
			echo "======all users you have======"
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
                        echo "NOTE: TYPE THE NAME OF USER OR UUID"
			read -p "please choose user to delete: " delete1
			read -p "did you want to delete home directory Y/n: " home;;
	        *)
                        echo "Invalid choice"
                        sleep 0.3;;
	
	esac
		case $choose in
			Y|y|yes|YES)
				sudo userdel -f -r $delete 
				sudo groupdel -f $delete;;
			n|N|No|NO|no)
				sleep 0.5;;
		*)
                        echo "Invalid choice"
                        sleep 0.3;;

		esac
		case $home in
			Y|y|YES|yes|Yes)
				sudo userdel -r $delete1;;
			n|N|NO|No|no)
				echo "==================="
				read -p "did you want to delete user group Y/n" group_del;;
	                *)
                        	echo "Invalid choice"
                    		sleep 0.3;;

		esac
			case $group_del in
			Y|y|yes|YES)
				sudo groupdel -f $delete1
				echo "user group deleted ";;
			n|N|No|NO|no)
				sleep 0.5;;
		*)
                        echo "Invalid choice"
                        sleep 0.3;;

		esac
done
}
set_limit_to_user_paswd(){

while true; do

	clear
	sleep 0.5
	echo "=========Set Limit To User========="
	echo "1.list user"
	echo "2.change specific settings"
	echo "3.simple change"
	echo "0.back to user menu"
	read -p "choose: " user_menu
	case $user_menu in
		0)
			user_menu;;
		1)
			echo "============"
			echo "choose user to list"
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			read -p "choose: " list
			chage -l $list;;
		2)
			sleep 0.3
			echo "=========="
			echo "1.chane min_days"
			echo "2.change max days"
			echo "3.set inactive"
			echo "4.change Last password change date"
			echo "5. set warn days"
			echo "6. set expire date"
			read -p "choose: " choose;;
		3)
			echo "=============="
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			echo "#############"
			read -p "choose user to modifiy: " user 
			echo "================="
                        read -p "set the min days: " mindays
                        sudo chage -m $mindays $user
                        read -p "set the max days to set a new password: " maxdays
                        sudo chage -M $maxdays $user
                        read -p "set the expire date: " expiredate
                        sudo chage -E $expiredate $user
                        read -p "set the inactive date: " inective
                        sudo chage -I $inective $user
                        read -p "set the warn day #the days user get warn when his passowrd close to expire: " warnday
                        sudo chage -W warnday $user
                        echo "=============="
                        echo "the final result: "
                        sudo chage -l $user
			sleep 1;;
                *)
                        echo "Invalid choice"
                        sleep 0.3;;
	
	esac
		case $choose in
			1)
				read -p "enter the min days: " min_days
				sudo chage -m $min_days $user $user;;
			2)
				read -p "enter the max days: " max_days
				sudo chage -M $max_days $user;;
			3)
				read -p "enter the inective days: " inective_days
				sudo chage -I $inective_days $user;;
			4)
				read -p "enter the last password date to edit it: " change_passwd
				sudo chage -d $change_passwd $user;;
			5)
				read -p "enter the warn days: " warn_days
				sudo chage -W $warn_day $user;;
			6)
				read -p "enter the expire days: " expire_days
				sudo chage -E $expire_date $user;;
                *)
                        echo "Invalid choice"
                        sleep 0.3;;

		esac

done
}
change_user_passwd(){
while true; do

	clear
	sleep 05
	echo "======Change User Passwd======"
	echo "0.back to user menu"
	echo "1.change user passwd"
	read -p "choose: " user_menu
	case $user_menu in
		0)
			user_menu;;
		1)
			echo "============="
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			echo "################"
			read -p "choose user to change/set password: " passwd
			sudo passwd $passwd;;


                *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
done
}

add_user_to_group(){
while true; do
	clear
	sleep 0.5
	echo "======Add Uset To Group======"
	echo "0.back to user menu"
	echo "1.add user to group"
	read -p "choose: " user_menu
	case $user_menu in
		0)
			user_menu;;
		1)
			echo "=============="
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			echo "####################"
			read -p "choose user to add from groups: " choose
			awk -F: '$3 >= 2000 {print $1}' /etc/group
			read -p "choose group to add user from: " groups_name
			sudo usermod -aG "$groups_name" "$choose";;
		*)
           		echo "Invalid choice"
			sleep 0.3;;
                *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
done
}
remove_user_from_group(){
while true; do

	clear
	sleep 0.5
	echo "======Remove User From Group======="
	echo "0.back to user menu"
	echo "1.remove user from group"
	read -p "choose: " user_menu
	case $user_menu in
		0)
			user_menu;;
		1)
			echo "=============="
                        awk -F: '$3 >= 1000 {print $1}' /etc/passwd
                        echo "####################"
                        read -p "choose uset to remove from group: " choose
                        echo "#####################"
                        sudo groups $choose
                        read -p "choose group to remove user from: " groups
                        sudo usermod -r -G $groups $choose;;
			
			
                *)
                        echo "Invalid choice"
                        sleep 0.3;;

		esac
done
}
get_info(){
while true; do
	clear
	sleep 0.5
	echo "======Get Info======"
	echo "0.back to user menu"
	echo "1.get info about specific user"
	read -p "choose: " user_menu
	case $user_menu in
		0)
			user_menu;;
		1)
			echo "=========="
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd
			read -p "choose user to get info about them: " user
			sudo id $user;;
                *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
done
}
all_users(){
while true; do
	echo "======All Users======"		
	echo "1.show all normal users"
	echo "0.back to user_menu"
	read -p "choose: " all_users
	case $all_users in
		0)
			user_menu;;
		1)
			awk -F: '$3 >= 1000 {print $1}' /etc/passwd;;
                *)
                        echo "Invalid choice"
                        sleep 0.3;;

	esac
done
}
main_menu(){
while true; do
	clear
	sleep 1
	echo "===Main Menu====="
	echo "1.Modify users"
	echo "2.Exit"
	read -p "choose: " choose
	case $choose in
		1|modify|users|Modify|users|modify|Users|y|Y|yes|Yes)
			user_menu
			break;;
		2|Exit|exit|exit|n|N|out)
			exit 0
			break;;
		*)
			echo "please enter vaild answer"
			sleep 1;;
		esac
	done
}
main_menu
