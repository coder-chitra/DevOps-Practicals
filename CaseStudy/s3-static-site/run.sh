aws configure                 # access key, secret key, region ap-south-1
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform output website_url  # open this URL in the browser
terraform destroy             # clean up when finished, to avoid charges