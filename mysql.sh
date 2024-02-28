log_file=/tmp/out
color="\e[32m"

echo -e "${color} disable mysql default version \e[0m"
dnf module disable mysql -y  &>> log_file
echo $?

echo -e "${color} Copying repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo  &>> log_file
 echo $?

echo -e "${color} Installing mysql \e[0m"
dnf install mysql-community-server -y  &>> log_file
 echo $?

echo -e "${color} Enabling mysql default version \e[0m"
systemctl enable mysqld  &>> log_file
echo $?

echo -e "${color} Starting mysql  \e[0m"
systemctl start mysqld  &>> log_file
 echo $?

echo -e "${color} Changing the default root password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1  &>> log_file
echo $?

