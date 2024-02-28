log_file=/tmp/out
color="\e[33m"

echo -e "${color} Installing Nginx \e[0m"
dnf install nginx -y &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi

echo -e "${color} copying reverse proxy  Nginx \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi

echo -e "${color} Removing default content Nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>> $log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi

echo -e "${color} extracting frontend zip \e[0m" &>> $log_file
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> $log_file
#echo $?

echo -e "${color} unzip frontend file \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> $log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi

echo -e "${color} Restarting Nginx \e[0m"
systemctl enable nginx
systemctl restart nginx

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi