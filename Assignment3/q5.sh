# set-up
EC2_IP="dummy-ip"
USERNAME="ubuntu"
KEY="mykey.pem"

#i)
mkdir -p /local_backup

scp -i "$KEY" \
    "$USERNAME@$EC2_IP:/home/ubuntu/example.txt" \
    /local_backup/

#ii)
mkdir -p /local_files

scp -i "$KEY" \
    "$USERNAME@$EC2_IP:/home/ubuntu/files/file1.txt" \
    "$USERNAME@$EC2_IP:/home/ubuntu/files/file2.txt" \
    "$USERNAME@$EC2_IP:/home/ubuntu/files/file3.txt" \
    /local_files/

#iii)
mkdir -p /web_backup

scp -r -i "$KEY" \
    "$USERNAME@$EC2_IP:/var/www" \
    /web_backup/


#iv)
scp -i "$KEY" \
    /local_reports/report.csv \
    "$USERNAME@$EC2_IP:/home/$USERNAME/reports/"

#v)
scp -i "$KEY" \
    /documents/doc1.pdf \
    /documents/doc2.pdf \
    /documents/doc3.pdf \
    "$USERNAME@$EC2_IP:/home/$USERNAME/docs/"

#vi)
scp -r -i "$KEY" \
    /images \
    "$USERNAME@$EC2_IP:/home/$USERNAME/media/"

#vii)
scp -C -i "$KEY" \
    /local_backup/largefile.zip \
    "$USERNAME@$EC2_IP:/home/$USERNAME/"

#viii)
scp -rp -i "$KEY" \
    /local_backup/project \
    "$USERNAME@$EC2_IP:/home/$USERNAME/"

#ix)
scp -v -i "$KEY" \
    /local_reports/report.csv \
    "$USERNAME@$EC2_IP:/home/$USERNAME/reports/"