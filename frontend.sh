echo -e "\e[31m Installing Nginx \e[0m"
dnf install nginx -y &>> /tmp/out

echo -e "\e[31m copying reverse proxy  Nginx \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> /tmp/out

echo -e "\e[31m Removing default content Nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/out

echo -e "\e[31m extracting fronend zip \e[0m" &>> /tmp/out
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31m unzip frontend file \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /tmp/out

echo -e "\e[31m Restarting Nginx \e[0m"
systemctl enable nginx
systemctl restart nginx