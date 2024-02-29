source common.sh


if [ -z "$1" ];then
  echo Pasword input missing in the first argument
  exit
  fi

MYSQL_ROOT_PASSWORD=$1


echo -e "${color} disable mysql default version \e[0m"
dnf module disable mysql -y  &>> log_file

status_check

echo -e "${color} Copying repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo  &>> log_file
 status_check

echo -e "${color} Installing mysql \e[0m"
dnf install mysql-community-server -y  &>> log_file
 status_check

echo -e "${color} Enabling mysql default version \e[0m"
systemctl enable mysqld  &>> log_file
status_check

echo -e "${color} Starting mysql  \e[0m"
systemctl start mysqld  &>> log_file
 status_check

echo -e "${color} Changing the default root password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD}  &>> log_file
status_check

