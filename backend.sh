log_file=/tmp/out
color="\e[32m"

echo -e "${color} disable node js default version \e[0m"
dnf module disable nodejs -y
echo -e "${color} enable node js 18 version \e[0m"
dnf module enable nodejs:18 -y

echo -e "${color} install nodeJs \e[0m"
dnf install nodejs -y

echo -e "${color} copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "${color} adding application user \e[0m"
useradd expense

echo -e "${color} creating application directory \e[0m"
mkdir /app

echo -e "${color} downloading the backend application \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

echo -e "${color} changing to application directory \e[0m"
cd /app
echo -e "${color} unzip the application \e[0m"
unzip /tmp/backend.zip

echo -e "${color} installing nodejs dependencies \e[0m"
npm install

echo -e "${color} installing the mysql client to load schema \e[0m"
dnf install mysql -y

echo -e "${color} load schema  \e[0m"
mysql -h mysql-dev.gdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql


echo -e "${color} Restarting the backed service \e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl start backend

