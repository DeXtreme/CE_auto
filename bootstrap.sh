#! bin/sh

sudo yum update
sudo yum install nginx -y
echo "<html><body>`hostname` is up and running</body></html>" > /usr/share/nginx/html/index.html
sudo systemctl start nginx