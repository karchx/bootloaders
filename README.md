
## Docker
```bash
docker build -t karch .

docker run --rm -it -v /tmp/.X11-unix/:/tmp/.X11-unix\
	-e "DISPLAY=:0" karch

or

docker run --rm -it -v /tmp/.X11-unix/:/tmp/.X11-unix\
	-e "DISPLAY=${DISPLAY:-:0.0}" karch
```

## compile

```bash
./run.sh file.asm
```

## articles
http://3zanders.co.uk/2017/10/13/writing-a-bootloader/
