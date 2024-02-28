log_file=/tmp/out
color="\e[32m"

echo -e "${color} disable node js default version \e[0m"
dnf module disable nodejs -y &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi


echo -e "${color} enable node js 18 version \e[0m"
dnf module enable nodejs:18 -y &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi

echo -e "${color} install nodeJs \e[0m"
dnf install nodejs -y &>> log_file

 if [ $? -eq 0 ]; then
   echo -e "\e[32m Success \e[0m"
 else
   echo -e "\e[31m Failure \e[0m"
  fi


echo -e "${color} copying backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>> log_file

 if [ $? -eq 0 ]; then
   echo -e "\e[32m Success \e[0m"
 else
   echo -e "\e[31m Failure \e[0m"
  fi

id expense &>> log_file
  if [ $? -ne 0 ];then
  echo -e "${color} adding application user \e[0m"
    useradd expense &>> log_file
   if [ $? -eq 0 ]; then
     echo -e "\e[32m Success \e[0m"
   else
     echo -e "\e[31m Failure \e[0m"
   fi
  fi


echo -e "${color} creating application directory \e[0m"
mkdir /app &>> log_file

 if [ $? -eq 0 ]; then
   echo -e "\e[32m Success \e[0m"
 else
   echo -e "\e[31m Failure \e[0m"
  fi


echo -e "${color} downloading the backend application \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> log_file

   if [ $? -eq 0 ]; then
     echo -e "\e[32m Success \e[0m"
   else
     echo -e "\e[31m Failure \e[0m"
    fi


echo -e "${color} changing to application directory \e[0m"
cd /app &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi


echo -e "${color} unzip the application \e[0m"
unzip /tmp/backend.zip &>> log_file

 if [ $? -eq 0 ]; then
   echo -e "\e[32m Success \e[0m"
 else
   echo -e "\e[31m Failure \e[0m"
  fi


echo -e "${color} installing nodejs dependencies \e[0m"
npm install &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi


echo -e "${color} installing the mysql client to load schema \e[0m"
dnf install mysql -y &>> log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32m Success \e[0m"
else
  echo -e "\e[31m Failure \e[0m"
 fi


echo -e "${color} load schema  \e[0m"
mysql -h mysql-dev.gdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> log_file

echo $?

 if [ $? -eq 0 ]; then
   echo -e "\e[32m Success \e[0m"
 else
   echo -e "\e[31m Failure \e[0m"
  fi

echo -e "${color} Restarting the backed service \e[0m"
systemctl daemon-reload &>> log_file
 #echo $?
systemctl enable backend &>> log_file
#echo $?
systemctl start backend &>> log_file

  if [ $? -eq 0 ]; then
    echo -e "\e[32m Success \e[0m"
  else
    echo -e "\e[31m Failure \e[0m"
   fi


