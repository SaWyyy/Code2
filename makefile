.PHONY: clean install
BIN=/usr/local/bin
LIB=/usr/lib

# dodanie reguł przyrostków
.c.o:
	gcc -c $<

# tworzenie plikow obiektowych
field.o: field.c
volume.o: volume.c
main.o: main.c

# tworzenie biblioteki statycznej
libfield.a: field.o
	ar rs $@ $<

# tworzenie biblioteki dynamicznej
libvolume.so: volume.o
	gcc -shared -o $@ $<

Code2: main.o libfield.a libvolume.so
	gcc -o $@ $^

# instalacja programu w katalogach systemowych
install: Code2
	@if [ -d $(BIN) ] && [ -d $(LIB) ]; \
		then \
		sudo cp Code2 $(BIN);\
		sudo chmod a+x $(BIN)/Code2;\
		sudo chmod og-w $(BIN)/Code2;\
		sudo cp libvolume.so $(LIB);\
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
