log_file=/tmp/out
color="\e[32m"

echo -e "${color} Installing Nginx \e[0m"
dnf install nginx -y &>> log_file
echo $?

echo -e "${color} copying reverse proxy  Nginx \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file
echo $?
echo -e "${color} Removing default content Nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>> $log_file
echo $?

echo -e "${color} extracting frontend zip \e[0m" &>> $log_file
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> $log_file
echo $?

echo -e "${color} unzip frontend file \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> $log_file
echo $?

echo -e "${color} Restarting Nginx \e[0m"
systemctl enable nginx
systemctl restart nginx
echo $?