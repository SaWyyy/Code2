.PHONY: clean install

# tworzenie plikow obiektowych
field.o: field.c
	gcc -c field.c
volume.o: volume.c
	gcc -c volume.c
main.o: main.c
	gcc -c main.c

# tworzenie biblioteki statycznej
libfield.a: field.o
	ar rs libfield.a field.o

# tworzenie biblioteki dynamicznej
libvolume.so: volume.o
	gcc -shared -o libvolume.so volume.o

Code2: main.o libfield.a libvolume.so
	gcc -o Code2 main.o libfield.a libvolume.so

# instalacja programu w katalogach systemowych
install: Code2
	@if [ -d /usr/local/bin ] && [ -d /usr/lib ]; \
		then \
		sudo cp Code2 /usr/local/bin;\
		sudo chmod a+x /usr/local/bin/Code2;\
		sudo chmod og-w /usr/local/bin/Code2;\
		sudo cp libvolume.so /usr/lib;\
		echo "Zainstalowano pomyslnie Code2 w /usr/local/bin";\
	else \
		echo "nie udalo sie zainstalowac Code2";\
	fi

clean:
	rm -f *.o
	rm -f *.so
	rm -f *.a
	rm Code2
	sudo rm -f /usr/local/bin/Code2
	sudo rm -f /usr/lib/libvolume.so
