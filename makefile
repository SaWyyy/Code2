.PHONY: clean install
BIN=/usr/local/bin
LIB=/usr/lib

INCLUDE=./include

# dodanie reguł wzorców do bibliotek
lib%.a: %.o
	ar rs $@ $^
lib%.so: %.o
	gcc -shared -o $@ $^

# dodanie reguł przyrostków
.c.o:
	gcc -c -I $(INCLUDE) $<

# tworzenie plikow obiektowych
field.o: field.c
volume.o: volume.c
main.o: main.c

# tworzenie biblioteki statycznej
libfield.a: field.o

# tworzenie biblioteki dynamicznej
libvolume.so: volume.o

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
	mkdir bin
	mkdir lib
	mv libfield.a lib
	mv libvolume.so lib
	mv Code2 bin

vpath %.c ./src
vpath %.h ./include
vpath %.so ./lib
vpath %.a ./lib

clean:
	$(RM) *.o *.a *.so Code2
	rm -r lib
	rm -r bin
	sudo rm -f /usr/local/bin/Code2
	sudo rm -f /usr/lib/libvolume.so
