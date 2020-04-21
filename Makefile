up:
	docker run --name="rpi-monitor" -d \
--restart always --device=/dev/vchiq --device=/dev/vcsm \
--volume=/opt/vc:/opt/vc --volume=/boot:/boot --volume=/sys:/dockerhost/sys:ro --volume=/etc:/dockerhost/etc:ro \
--volume=/proc:/dockerhost/proc:ro --volume=/usr/lib:/dockerhost/usr/lib:ro --volume=/etc/localtime:/etc/localtime:ro \
-p=8888:8888 \
ikaritw/rpi-monitor:2.12

build:
	docker build --tag ikaritw/rpi-monitor:2.12 .
