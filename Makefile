publish:
	hugo -s ./

serve:
	hugo server -wDs ./ -d dev & xdg-open http://localhost:1313/

push:
	aws s3 cp public/ s3://blog.stuartzahn.net --recursive  --include "*" --acl public-read